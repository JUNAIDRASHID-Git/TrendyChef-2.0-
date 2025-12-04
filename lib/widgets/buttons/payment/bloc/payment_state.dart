part of 'payment_bloc.dart';

@immutable
sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

final class PaymentLoading extends PaymentState {}

final class PaymentLoaded extends PaymentState {
  final String paymentUrl;

  PaymentLoaded({required this.paymentUrl});
}

final class PaymentError extends PaymentState {
  final String error;

  PaymentError({required this.error});
}
