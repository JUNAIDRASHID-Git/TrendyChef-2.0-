import 'package:hive/hive.dart';
import 'package:trendychef/core/services/models/cart/cart.dart';

Future<void> removeFromLocalCart({required int productId}) async {
  final cartBox = Hive.box<CartModel>('cartBox');

  CartModel? cart = cartBox.get('userCart');
  if (cart == null) return;

  // Create new items list
  final updatedItems = cart.items
      .where((item) => item.productId != productId)
      .toList();

  // Create a new cart object
  final updatedCart = CartModel(
    cartId: cart.cartId,
    userId: cart.userId,
    items: updatedItems,
    createdAt: cart.createdAt,
    updatedAt: DateTime.now(),
  );

  // Save it
  await cartBox.put('userCart', updatedCart);
}
