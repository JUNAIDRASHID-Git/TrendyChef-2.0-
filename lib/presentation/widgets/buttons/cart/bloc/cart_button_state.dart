part of 'cart_button_bloc.dart';

@immutable
sealed class CartButtonState {}

final class CartButtonInitial extends CartButtonState {}

final class CartButtonLoading extends CartButtonState {}

final class CartButtonLoaded extends CartButtonState {
  final bool isItemExist;

  CartButtonLoaded({required this.isItemExist});
}

final class CartButtonError extends CartButtonState {}
