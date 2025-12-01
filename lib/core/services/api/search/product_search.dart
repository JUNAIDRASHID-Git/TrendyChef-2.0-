import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:trendychef/core/const/api_endpoints.dart';
import 'package:trendychef/core/services/models/product/product_model.dart';

Future<List<ProductModel>> searchProduct(String searchData) async {
  final uri = Uri.parse("$userProductsEndpoint?search=$searchData");

  try {
    final response = await http.get(
      uri,
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );

    if (response.statusCode == 200) {
      log("Products data fetched");
      final List<dynamic> jsonData = json.decode(response.body);
      final products = jsonData.map((e) => ProductModel.fromJson(e)).toList();
      return products.toList();
    } else {
      throw Exception("failed to fetch the product");
    }
  } catch (e) {
    log("Error fetching Products: $e");
    rethrow;
  }
}
