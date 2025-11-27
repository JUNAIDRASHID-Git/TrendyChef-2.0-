import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trendychef/core/const/api_endpoints.dart'; // contains baseHost

Future<bool> deleteCartItemUniversal(int productId) async {
  final prefs = await SharedPreferences.getInstance();

  final userToken = prefs.getString("idtoken");
  final guestId = prefs.getString("guest_id");

  try {
    // --------------------------------------------------------
    // 🔥 1. USER LOGGED IN → Delete from User Cart
    // --------------------------------------------------------
    if (userToken != null && userToken.isNotEmpty) {
      final uri = Uri.parse("$userCartEndpoint$productId");

      final response = await http.delete(
        uri,
        headers: {
          "Authorization": userToken,
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        debugPrint("✅ User cart item deleted");
        return true;
      } else {
        debugPrint("❌ Failed to delete USER cart item: ${response.body}");
        return false;
      }
    }

    // --------------------------------------------------------
    // 🔥 2. GUEST USER → Delete from Guest Cart
    // --------------------------------------------------------
    if (guestId == null || guestId.isEmpty) {
      debugPrint("⚠️ No guest_id found");
      return false;
    }

    final guestUri = Uri.parse(
      "$baseHost/guest/cart/$productId?guest_id=$guestId",
    );

    final guestResponse = await http.delete(
      guestUri,
      headers: {"Content-Type": "application/json"},
    );

    if (guestResponse.statusCode == 200) {
      debugPrint("✅ Guest cart item deleted");
      return true;
    } else {
      debugPrint("❌ Failed to delete GUEST cart item: ${guestResponse.body}");
      return false;
    }
  } catch (e) {
    debugPrint("❌ Error deleting cart item: $e");
    return false;
  }
}
