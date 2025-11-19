part of 'cart_button_bloc.dart';

@immutable
sealed class CartButtonEvent {}

final class CartAddEvent extends CartButtonEvent {
  final CartItemModel item;

  CartAddEvent({required this.item});
}
