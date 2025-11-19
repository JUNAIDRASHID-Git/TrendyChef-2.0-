import 'package:hive_flutter/adapters.dart';
import 'package:trendychef/core/services/models/cart/cart.dart';
import 'package:trendychef/core/services/models/cart/cart_item.dart';

Future<void> addToLocalCart({required CartItemModel cartItem}) async {
  final cartBox = Hive.box<CartModel>('cartBox');

  // Get or create the cart
  CartModel cart = cartBox.get('userCart') ??
      CartModel(
        cartId: 1,
        userId: "local",
        items: [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

  // Check if product already exists in cart
  bool exists = cart.items.any((item) => item.productId == cartItem.productId);

  if (!exists) {
    // Add only if not already inside the cart
    cart.items.add(cartItem);
    cart.updatedAt = DateTime.now();

    // Save updated cart
    await cartBox.put('userCart', cart);
  }
}
