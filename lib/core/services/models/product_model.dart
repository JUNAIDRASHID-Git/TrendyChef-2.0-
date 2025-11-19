class ProductModel {
  int? id;
  String eName;
  String? arName;
  String? eDescription;
  String? arDescription;
  double salePrice;
  double regularPrice;
  double baseCost;
  String image;
  double weight;
  int stock;
  List<String> categories;
  DateTime createdAt;
  DateTime updatedAt;

  ProductModel({
    this.id,
    required this.eName,
    this.arName,
    this.eDescription,
    this.arDescription,
    required this.salePrice,
    required this.regularPrice,
    required this.baseCost,
    required this.image,
    required this.weight,
    required this.stock,
    required this.categories,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['ID'],
      eName: json['EName'] ?? '',
      arName: json['ARName'],
      eDescription: json['EDescription'],
      arDescription: json['ARDescription'],
      salePrice: (json['SalePrice'] as num?)?.toDouble() ?? 0.0,
      regularPrice: (json['RegularPrice'] as num?)?.toDouble() ?? 0.0,
      baseCost: (json['BaseCost'] as num?)?.toDouble() ?? 0.0,
      image: json['Image'] ?? '',
      weight: (json['Weight'] as num?)?.toDouble() ?? 0.0,
      stock: (json['Stock'] as num?)?.toInt() ?? 0,
      categories:
          (json['Categories'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      createdAt: DateTime.tryParse(json['CreatedAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['UpdatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'EName': eName,
      'ARName': arName,
      'EDescription': eDescription,
      'ARDescription': arDescription,
      'SalePrice': salePrice,
      'RegularPrice': regularPrice,
      'BaseCost': baseCost,
      'Image': image,
      'Weight': weight,
      'Stock': stock,
      'Categories': categories,
      'CreatedAt': createdAt.toIso8601String(),
      'UpdatedAt': updatedAt.toIso8601String(),
    };
  }
}
