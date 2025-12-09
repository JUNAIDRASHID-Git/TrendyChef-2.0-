import 'package:trendychef/core/services/models/product/product_model.dart';

class CategoryModel {
  int iD;
  String ename;
  String arname;
  String image;
  List<ProductModel>? products;

  CategoryModel({
    required this.iD,
    required this.ename,
    required this.arname,
    required this.image,
    this.products,
  });

  CategoryModel.fromJson(Map<String, dynamic> json)
    : iD = json['ID'],
      ename = json['EName'],
      arname = json['ARName'],
      image = json['Image'] {
    if (json['Products'] != null) {
      products = <ProductModel>[];
      json['Products'].forEach((v) {
        products?.add(ProductModel.fromJson(v));
      });
    }
  }
}
