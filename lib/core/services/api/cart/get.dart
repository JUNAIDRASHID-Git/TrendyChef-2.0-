import 'dart:developer';
import 'package:hive/hive.dart';
import 'package:trendychef/core/services/models/cart/cart.dart';
import 'package:trendychef/core/services/models/cart/cart_item.dart';

List<CartItemModel> getCartLocal() {
  final cartBox = Hive.box<CartModel>('cartBox');

  // Assuming there is only ONE cart stored
  if (cartBox.isEmpty) {
    log("Cart is empty");
    return [];
  }

  final CartModel cart = cartBox.getAt(0)!;

  log("Local cart items: ${cart.items.length}");

  return cart.items;
}
