import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trendychef/core/const/api_endpoints.dart';
import 'package:trendychef/core/services/models/user/user.dart';

Future<UserModel> getUser() async {
  try {
    final url = Uri.parse(userEndpoint);
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString("idtoken");

    if (token == null || token.isEmpty) {
      return UserModel(
        id: "1",
        name: "user",
        phone: "",
        address: Address(
          street: "street",
          city: "city",
          state: "state",
          postalCode: "postalCode",
          country: "country",
        ),
      );
    }

    final response = await http.get(
      url,
      headers: {"Authorization": token, "Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return UserModel.fromJson(jsonData);
    } else {
      debugPrint(
        "❌ Failed to fetch user: ${response.statusCode} ${response.body}",
      );
      throw Exception("Failed to fetch user: ${response.statusCode}");
    }
  } catch (e) {
    debugPrint("❌ Exception occurred while fetching user: $e");
    throw Exception("Failed to fetch user: $e");
  }
}
