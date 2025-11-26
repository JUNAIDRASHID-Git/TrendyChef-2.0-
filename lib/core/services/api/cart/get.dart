import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trendychef/core/const/api_endpoints.dart';
import 'package:trendychef/core/services/models/cart/cart_item.dart';

/// Fetch guest cart items using guest ID stored in SharedPreferences
Future<List<CartItemModel>> getGuestCart() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final guestId = prefs.getString('guest_id');

    if (guestId == null || guestId.isEmpty) {
      debugPrint("No guest ID found in SharedPreferences");
      return [];
    }

    final response = await http.get(
      Uri.parse("$baseHost/guest/cart?guest_id=$guestId"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);

      final jsonResponce = jsonData
          .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>))
          .toList();

      return jsonResponce;
    } else {
      debugPrint(
        "Failed to fetch guest cart. Status code: ${response.statusCode}, Body: ${response.body}",
      );
      return [];
    }
  } catch (e, stackTrace) {
    debugPrint("Error fetching guest cart: $e\n$stackTrace");
    return [];
  }
}
