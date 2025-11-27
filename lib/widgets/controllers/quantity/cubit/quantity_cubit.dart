import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/core/services/api/cart/get.dart';
import 'package:trendychef/core/services/api/cart/post.dart';

class QuantityState {
  final Map<int, int> quantities;
  final Map<int, int> stocks;

  QuantityState({
    required this.quantities,
    required this.stocks,
  });

  QuantityState copyWith({
    Map<int, int>? quantities,
    Map<int, int>? stocks,
  }) {
    return QuantityState(
      quantities: quantities ?? this.quantities,
      stocks: stocks ?? this.stocks,
    );
  }
}

class QuantityCubit extends Cubit<QuantityState> {
  QuantityCubit() : super(QuantityState(quantities: {}, stocks: {}));

  /// load cart items initially
  Future<void> loadCart() async {
    final items = await getCartItems();

    final q = <int, int>{};
    final s = <int, int>{};

    for (var item in items) {
      q[item.productId] = item.quantity;
      s[item.productId] = item.stock;
    }

    emit(QuantityState(quantities: q, stocks: s));
  }

  int getQuantity(int id) => state.quantities[id] ?? 1;
  int getStock(int id) => state.stocks[id] ?? 1;

  Future<void> updateQuantity(int id, int qty) async {
    final updatedQuantities = Map<int, int>.from(state.quantities);
    updatedQuantities[id] = qty;

    emit(state.copyWith(quantities: updatedQuantities));

    await addOrUpdateCartItem(productId: id, quantity: qty);
  }

  void increase(int id) {
    final qty = getQuantity(id);
    final stock = getStock(id);

    if (qty < stock) {
      updateQuantity(id, qty + 1);
    }
  }

  void decrease(int id) {
    final qty = getQuantity(id);
    if (qty > 1) {
      updateQuantity(id, qty - 1);
    }
  }
}
