import 'package:hive/hive.dart';
import 'package:trendychef/core/services/models/cart/cart_item.dart';

part 'cart.g.dart';

@HiveType(typeId: 1)
class CartModel extends HiveObject {
  @HiveField(0)
  int cartId;

  @HiveField(1)
  String userId;

  @HiveField(2)
  List<CartItemModel> items;

  @HiveField(3)
  DateTime createdAt;

  @HiveField(4)
  DateTime updatedAt;

  CartModel({
    required this.cartId,
    required this.userId,
    required this.items,
    required this.createdAt,
    required this.updatedAt,
  });
}
