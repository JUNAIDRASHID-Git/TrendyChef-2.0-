part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

final class CartFetchEvent extends CartEvent {}

