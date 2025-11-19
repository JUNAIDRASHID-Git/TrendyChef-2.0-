import 'package:dio/dio.dart';
import 'package:trendychef/core/const/api_endpoints.dart';
import 'package:trendychef/core/services/models/product_model.dart';

final Dio _dio = Dio(
  BaseOptions(
    baseUrl: userProductsEndpoint,
    headers: {'Content-Type': 'application/json; charset=UTF-8'},
    connectTimeout: Duration(milliseconds: 10000),
    receiveTimeout: Duration(milliseconds: 10000),
  ),
);

Future<List<ProductModel>> getAllProducts() async {
  try {
    final response = await _dio.get('');
    if (response.statusCode == 200) {
      final data = response.data as List;
      return data.map((e) => ProductModel.fromJson(e)).toList();
    } else {
      throw Exception(
        "Failed to fetch products. Status: ${response.statusCode}",
      );
    }
  } catch (e) {
    rethrow;
  }
}

Future<ProductModel> getProductByID({required String productID}) async {
  try {
    final response = await _dio.get('/$productID');

    if (response.statusCode == 200) {
      return ProductModel.fromJson(response.data);
    } else {
      throw Exception(
        "Failed to fetch product. Status: ${response.statusCode}",
      );
    }
  } catch (e) {
    rethrow;
  }
}
