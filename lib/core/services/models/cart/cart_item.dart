import 'package:hive/hive.dart';

part 'cart_item.g.dart';

@HiveType(typeId: 2)
class CartItemModel extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  int cartId;

  @HiveField(2)
  int productId;

  @HiveField(3)
  String productEName;

  @HiveField(4)
  String? productArName;

  @HiveField(5)
  String? productImage;

  @HiveField(6)
  int productStock;

  @HiveField(7)
  double productSalePrice;

  @HiveField(8)
  double productRegularPrice;

  @HiveField(9)
  double weight;

  @HiveField(10)
  int quantity;

  @HiveField(11)
  DateTime addedAt;

  CartItemModel({
    required this.id,
    required this.cartId,
    required this.productId,
    required this.productEName,
    this.productArName,
    this.productImage,
    required this.productStock,
    required this.productSalePrice,
    required this.productRegularPrice,
    required this.weight,
    required this.quantity,
    required this.addedAt,
  });
}
