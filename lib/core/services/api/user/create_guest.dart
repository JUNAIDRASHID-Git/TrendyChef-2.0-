import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trendychef/core/const/api_endpoints.dart';

Future<String?> createGuestUser() async {
  final prefs = await SharedPreferences.getInstance();
  final dio = Dio();

  final url = '$baseHost/auth/guest';

  try {
    final response = await dio.post(url);

    if (response.statusCode == 200) {
      final data = response.data;

      final guestId = data['guest_id'];
      if (guestId == null) {
        return null;
      }

      // Save to SharedPreferences
      await prefs.setString("guest_id", guestId);

      return guestId;
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}
