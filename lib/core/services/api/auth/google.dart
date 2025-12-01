import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trendychef/core/const/api_endpoints.dart';

/// Sends idToken + guestId to backend, stores returned JWT (key: 'idtoken')
/// Returns a Map with response data on success, throws Exception on failure.
Future<Map<String, dynamic>> userGoogleAuthHandler(
  String idToken,
) async {
  final uri = Uri.parse(googleAuthEndpoind);
  final prefs = await SharedPreferences.getInstance();
  final guestId = prefs.getString("guest_id");

  try {
    final body = jsonEncode({'idToken': idToken, 'guest_id': guestId});

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode != 200) {
      final err = response.body.isNotEmpty ? response.body : 'Unknown error';
      debugPrint('❌ Backend returned HTTP ${response.statusCode}: $err');
      throw Exception('Authentication failed: ${response.statusCode} $err');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;

    // Basic validation
    final token = data['token'] ?? data['idtoken'];
    if (token == null || (token is String && token.isEmpty)) {
      debugPrint('❌ Backend response missing token: ${response.body}');
      throw Exception('Authentication failed: missing token');
    }

    // Save to SharedPreferences under a single agreed key 'idtoken'
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('idtoken', token as String);

    // Also save other optional fields if present (non-null)
    if (data['email'] != null) {
      await prefs.setString('email', data['email'] as String);
    }
    if (data['name'] != null) {
      await prefs.setString('name', data['name'] as String);
    }
    if (data['picture'] != null) {
      await prefs.setString('picture', data['picture'] as String);
    }

    debugPrint('✅ Authentication successful: $data');
    return data;
  } catch (e) {
    debugPrint('❌ Error during authentication: $e');
    rethrow;
  }
}
