import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:trendychef/core/services/models/cart/cart.dart';

Future<void> updateItemQuantityInLocalCart({
  required int productId,
  required int newQuantity,
}) async {
  try {
    if (!Hive.isBoxOpen('cartBox')) {
      await Hive.openBox<CartModel>('cartBox');
    }

    final cartBox = Hive.box<CartModel>('cartBox');
    final cart = cartBox.get('userCart');

    if (cart == null) {
      if (kDebugMode) print("No local cart found.");
      return;
    }

    // Modify the item inside the list
    final updatedItems = cart.items.map((item) {
      if (item.productId == productId) {
        // Update the mutable property directly instead of using copyWith
        item.quantity = newQuantity;
        return item;
      }
      return item;
    }).toList();

    // Create updated cart by updating the existing cart instance
    cart.items = updatedItems;
    cart.updatedAt = DateTime.now();

    await cartBox.put('userCart', cart);

    if (kDebugMode) {
      print("Quantity updated successfully for productId: $productId");
    }
  } catch (e, st) {
    if (kDebugMode) {
      print("Error updating item quantity: $e");
      print(st);
    }
  }
}
