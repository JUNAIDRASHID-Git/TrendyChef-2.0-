import 'package:dio/dio.dart';
import 'package:trendychef/core/const/api_endpoints.dart';
import 'dart:developer';

import 'package:trendychef/core/services/models/category.dart';

final Dio _dio = Dio(
  BaseOptions(
    baseUrl: userCategoryProductsEndpoint,
    headers: {'Content-Type': 'application/json; charset=UTF-8'},
    connectTimeout: Duration(milliseconds: 10000),
    receiveTimeout: Duration(milliseconds: 10000),
  ),
);

Future<List<CategoryModel>> getAllCategoryWithProducts() async {
  try {
    final response = await _dio.get('', options: Options());

    if (response.statusCode == 200) {
      log("✅ Categories with products fetched successfully");
      final List<dynamic> data = response.data;
      return data.map((e) => CategoryModel.fromJson(e)).toList();
    } else {
      log("❌ Server responded with ${response.statusCode}: ${response.data}");
      throw Exception("Failed to fetch category data");
    }
  } catch (e, st) {
    log("❌ Error fetching category data: $e\n$st");
    rethrow;
  }
}
