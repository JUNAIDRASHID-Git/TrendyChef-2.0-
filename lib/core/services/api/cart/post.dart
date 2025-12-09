import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:trendychef/core/const/api_endpoints.dart'; // baseHost
import 'package:trendychef/core/services/api/user/create_guest.dart';
import 'package:trendychef/core/services/models/cart/cart_item.dart';

/// Add or Update Cart Item (Works for User & Guest)
Future<CartItemModel?> addOrUpdateCartItem({
  required int productId,
  required int quantity,
}) async {
  final prefs = await SharedPreferences.getInstance();

  final userToken = prefs.getString('idtoken'); // logged-in user token
  var guestId = prefs.getString('guest_id'); // guest user id

  try {
    // -----------------------------------------------------------------
    // 🔥 1. USER LOGGED IN → Hit user cart API
    // -----------------------------------------------------------------
    if (userToken != null && userToken.isNotEmpty) {
      final uri = Uri.parse(userCartEndpoint);

      final response = await http.post(
        uri,
        headers: {
          "Authorization": userToken,
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "product_id": productId.toString(),
          "quantity": quantity,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return CartItemModel.fromJson(data);
      } else {
        debugPrint("❌ Failed to add user cart: ${response.body}");
        return null;
      }
    }

    // -----------------------------------------------------------------
    // 🔥 2. GUEST USER → Hit guest cart API
    // -----------------------------------------------------------------
    if (guestId == null || guestId.isEmpty) {
      guestId = await createGuestUser();

      if (guestId != null) {
        await prefs.setString("guest_id", guestId);
      }
      debugPrint("⚠️ No guest_id found");
      return null;
    }

    final guestUri = Uri.parse("$baseHost/guest/cart?guest_id=$guestId");

    final response = await http.post(
      guestUri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "product_id": productId.toString(),
        "quantity": quantity,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return CartItemModel.fromJson(jsonDecode(response.body));
    } else {
      debugPrint("❌ Failed to add guest cart: ${response.body}");
      return null;
    }
  } catch (e) {
    debugPrint("❌ Error adding/updating cart: $e");
    return null;
  }
}
