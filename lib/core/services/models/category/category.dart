import 'package:trendychef/core/services/models/product/product_model.dart';

class CategoryModel {
  final int id;
  final String ename;
  final String arname;
  final String? image;
  final List<ProductModel>? products;

  CategoryModel({
    required this.id,
    required this.ename,
    required this.arname,
    this.image,
    this.products,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['ID'] as int,
      ename: json['EName'] as String,
      arname: json['ARName'] as String,
      image: json['Image'], // nullable ✔
      products: json['Products'] != null
          ? (json['Products'] as List)
              .map((e) => ProductModel.fromJson(e))
              .toList()
          : null,
    );
  }
}
