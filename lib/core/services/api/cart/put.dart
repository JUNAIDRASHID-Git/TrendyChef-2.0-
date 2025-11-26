import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trendychef/core/const/api_endpoints.dart';

Future<bool> updateGuestCartItem({
  required int productId,
  required int quantity,
}) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final guestId = prefs.getString('guest_id');
    if (guestId == null || guestId.isEmpty) return false;

    final response = await http.post(
      Uri.parse("$baseHost/guest/cart?guest_id=$guestId"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "product_id": productId.toString(),
        "quantity": quantity,
      }),
    );

    return response.statusCode == 200 || response.statusCode == 201;
  } catch (e) {
    debugPrint("Error updating guest cart item: $e");
    return false;
  }
}
