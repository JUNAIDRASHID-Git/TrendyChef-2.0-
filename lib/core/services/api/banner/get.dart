import 'package:dio/dio.dart';
import 'package:trendychef/core/const/api_endpoints.dart';
import 'package:trendychef/core/services/models/banner/banner.dart';

final Dio dio = Dio(
  BaseOptions(
    baseUrl: baseHost,
    headers: {'Content-Type': 'application/json', 'X-API-KEY': apiKey},
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ),
);

Future<List<BannerModel>> fetchBanner() async {
  try {
    final response = await dio.get("/admin/banner/");

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      return data.map((e) => BannerModel.fromJson(e)).toList();
    } else {
      throw Exception("Server error");
    }
  } catch (_) {
    throw Exception("Server error");
  }
}
