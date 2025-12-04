part of 'checkout_bloc.dart';

@immutable
sealed class CheckoutState {}

final class CheckoutInitial extends CheckoutState {}

final class CheckoutLoading extends CheckoutState {}

final class CheckoutLoaded extends CheckoutState {
  final UserModel user;
  final List<CartItemModel> cartItems;

  CheckoutLoaded({required this.user, required this.cartItems});

  double get totalAmount => cartItems.fold(
    0.0,
    (sum, item) => sum + (item.productSalePrice * item.quantity),
  );

  double get totalRegularAmount => cartItems.fold(
    0.0,
    (sum, item) => sum + (item.productRegularPrice * item.quantity),
  );

  double get totalKg =>
      cartItems.fold(0.0, (sum, item) => sum + (item.weight * item.quantity));

  double get shippingCost {
    final kg = totalKg;
    if (kg == 0) return 0;
    return ((kg / 30).ceil()) * 30;
  }
}

final class CheckoutError extends CheckoutState {
  final String error;

  CheckoutError({required this.error});
}
