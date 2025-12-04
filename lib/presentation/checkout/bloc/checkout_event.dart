part of 'checkout_bloc.dart';

@immutable
sealed class CheckoutEvent {}

final class FetchDataCheckoutEvent extends CheckoutEvent {}
