part of 'cart_button_bloc.dart';

@immutable
sealed class CartButtonEvent {}

final class CartAddEvent extends CartButtonEvent {
  final CartItemModel item;

  CartAddEvent({required this.item});
}

final class CheckProductExisting extends CartButtonEvent {
  final int productID;

  CheckProductExisting({required this.productID});
}

final class CartUpdateQuantityEvent extends CartButtonEvent {
  final int productID;
  final int quantity;

  CartUpdateQuantityEvent({
    required this.productID,
    required this.quantity,
  });
}


class CartDeleteEvent extends CartButtonEvent {
  final int productID;

  CartDeleteEvent({required this.productID});
}
