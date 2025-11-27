import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trendychef/core/const/api_endpoints.dart';
import 'package:trendychef/core/services/models/cart/cart_item.dart';


Future<List<CartItemModel>> getCartItems() async {
  final prefs = await SharedPreferences.getInstance();

  final userToken = prefs.getString("idtoken");    // logged-in user
  final guestId = prefs.getString("guest_id");     // guest user

  try {
    // ---------------------------------------------------
    // 🔥 1. IF USER LOGGED IN → FETCH USER CART
    // ---------------------------------------------------
    if (userToken != null && userToken.isNotEmpty) {
      final uri = Uri.parse(userCartEndpoint);

      final response = await http.get(
        uri,
        headers: {
          "Authorization": userToken,
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        return data.map((e) => CartItemModel.fromJson(e)).toList();
      } else {
        debugPrint("❌ Failed to fetch USER cart: ${response.body}");
        return [];
      }
    }

    // ---------------------------------------------------
    // 🔥 2. IF NO USER → FETCH GUEST CART
    // ---------------------------------------------------
    if (guestId == null || guestId.isEmpty) {
      debugPrint("⚠️ No guest ID found");
      return [];
    }

    final uri = Uri.parse("$baseHost/guest/cart?guest_id=$guestId");

    final response = await http.get(
      uri,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => CartItemModel.fromJson(e)).toList();
    } else {
      debugPrint("❌ Failed to fetch GUEST cart: ${response.body}");
      return [];
    }

  } catch (e, stack) {
    debugPrint("❌ Cart fetch error: $e");
    debugPrint(stack.toString());
    return [];
  }
}
