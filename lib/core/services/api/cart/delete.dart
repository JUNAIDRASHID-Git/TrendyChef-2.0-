import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:trendychef/core/services/models/cart/cart.dart';

Future<void> removeFromLocalCart({required int productId}) async {
  try {
    if (!Hive.isBoxOpen('cartBox')) {
      await Hive.openBox<CartModel>('cartBox');
    }
    final cartBox = Hive.box<CartModel>('cartBox');

    CartModel? cart = cartBox.get('userCart');

    if (cart == null) {
      if (kDebugMode) {
        print('No local cart found.');
      }
      return;
    }

    final updatedItems = cart.items
        .where((item) => item.productId != productId)
        .toList();

    if (updatedItems.length == cart.items.length) {
      if (kDebugMode) {
        print('Item with productId $productId not found in the local cart.');
      }
      return;
    }

    final updatedCart = CartModel(
      cartId: cart.cartId,
      userId: cart.userId,
      items: updatedItems,
      createdAt: cart.createdAt,
      updatedAt: DateTime.now(),
    );

    await cartBox.put('userCart', updatedCart);
    if (kDebugMode) {
      print('Item removed from local cart successfully.');
    }
  } catch (e, stackTrace) {
    if (kDebugMode) {
      print('Error removing item from local cart: $e');
    }
    if (kDebugMode) {
      print(stackTrace);
    }
  }
}
