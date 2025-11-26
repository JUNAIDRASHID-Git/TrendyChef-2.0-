import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/core/services/api/cart/get.dart';
import 'package:trendychef/core/services/api/cart/post.dart';
import 'package:trendychef/core/services/api/cart/delete.dart';
import 'package:trendychef/core/services/api/cart/put.dart';
import 'package:trendychef/core/services/models/cart/cart_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartState {
  final List<CartItemModel> items;

  CartState({required this.items});

  double get totalAmount => items.fold(
    0.0,
    (sum, item) => sum + (item.productSalePrice * item.quantity),
  );

  double get totalKg =>
      items.fold(0.0, (sum, item) => sum + (item.weight * item.quantity));

  double get shippingCost {
    final kg = totalKg;
    if (kg == 0) return 0;
    return ((kg / 30).ceil()) * 30;
  }

  CartState copyWith({List<CartItemModel>? items}) =>
      CartState(items: items ?? this.items);
}

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState(items: []));

  /// Load cart from backend
  Future<void> loadCart() async {
    try {
      final items = await getGuestCart();
      emit(CartState(items: items));
    } catch (e) {
      // Failure handling: keep previous state or emit empty list
      emit(CartState(items: []));
    }
  }

  bool isInCart(int productId) =>
      state.items.any((i) => i.productId == productId);

  int getQuantity(int productId) =>
      state.items.firstWhere((i) => i.productId == productId).quantity;

  int getStock(int productId) =>
      state.items.firstWhere((i) => i.productId == productId).stock;

  Future<void> addToCart(int productId, {int quantity = 1}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final guestId = prefs.getString('guest_id');
      await addItemToGuestCart(
        productId: productId,
        guestId: guestId ?? '',
        quantity: quantity,
      );
      await loadCart(); // refresh local state from server
    } catch (e) {
      // handle error (e.g. show snackbar via BlocListener)
    }
  }

  Future<void> removeFromCart(int productId) async {
    try {
      await deleteGuestCartItem(productId);
      await loadCart();
    } catch (e) {
      print("Remove from cart failed: $e");
    }
  }

  Future<void> updateQuantity(int productId, int qty) async {
    try {
      await updateGuestCartItem(productId: productId, quantity: qty);
      // Option A (safe): reload from server to get latest item representation
      await loadCart();
    } catch (e) {}
  }

  void increase(int productId) {
    final q = getQuantity(productId);
    final s = getStock(productId);
    if (q < s) updateQuantity(productId, q + 1);
  }

  void decrease(int productId) {
    final q = getQuantity(productId);
    if (q > 1) updateQuantity(productId, q - 1);
  }
}
