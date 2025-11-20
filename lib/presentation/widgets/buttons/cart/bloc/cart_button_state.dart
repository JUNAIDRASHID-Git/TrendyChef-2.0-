part of 'cart_button_bloc.dart';

@immutable
sealed class CartButtonState {}

final class CartButtonInitial extends CartButtonState {}

final class CartButtonLoading extends CartButtonState {}

class CartItemExist extends CartButtonState {
  final int productId;

  CartItemExist({required this.productId});
}

class CartItemNotExist extends CartButtonState {
  final int productId;

  CartItemNotExist({required this.productId});
}

class CartItemQuantityUpdated extends CartButtonState {
  final int productId;
  final int quantity;

  CartItemQuantityUpdated({
    required this.productId,
    required this.quantity,
  });
}


final class CartButtonError extends CartButtonState {
  final String message;

  CartButtonError({required this.message});
}
