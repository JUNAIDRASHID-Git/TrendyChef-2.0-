import 'dart:developer';
import 'package:flutter/foundation.dart';
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

Future<int> getItemQuantityFromLocalCart(int productId) async {
  try {
    if (!Hive.isBoxOpen('cartBox')) {
      await Hive.openBox<CartModel>('cartBox');
    }

    final cartBox = Hive.box<CartModel>('cartBox');
    final cart = cartBox.get('userCart');

    if (cart == null) {
      if (kDebugMode) print("No local cart found.");
      return 1; // default safe value
    }

    try {
      final item = cart.items.firstWhere((e) => e.productId == productId);
      return item.quantity;
    } on StateError {
      if (kDebugMode) print("Item not found for productId: $productId");
      return 1; // default safe value
    }
  } catch (e, st) {
    if (kDebugMode) {
      print("Error fetching quantity: $e");
      print(st);
    }
    return 1; // fallback safe value
  }
}
