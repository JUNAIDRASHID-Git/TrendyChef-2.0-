import 'package:dio/dio.dart';
import 'package:trendychef/core/const/api_endpoints.dart';
import 'package:trendychef/core/services/models/category/category.dart';

final Dio _dio = Dio(
  BaseOptions(
    baseUrl: baseHost,
    headers: {'Content-Type': 'application/json; charset=UTF-8'},
    connectTimeout: const Duration(milliseconds: 10000),
    receiveTimeout: const Duration(milliseconds: 10000),
  ),
);

Future<List<CategoryModel>> getAllCategoryWithProducts() async {
  try {
    final response = await _dio.get("/public/categories");

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      return data.map((e) => CategoryModel.fromJson(e)).toList();
    } else {
      throw Exception("Server error");
    }
  } catch (_) {
    throw Exception("Server error");
  }
}

Future<CategoryModel> getCategoryById(String id) async {
  try {
    final response = await _dio.get("/public/categories/$id");

    if (response.statusCode == 200) {
      return CategoryModel.fromJson(response.data);
    } else {
      throw Exception("Server error");
    }
  } catch (_) {
    throw Exception("Server error");
  }
}
