part of 'payment_bloc.dart';

@immutable
sealed class PaymentEvent {}

final class InitPaymentEvent extends PaymentEvent {
  final PaymentModel paymentData;

  InitPaymentEvent({required this.paymentData});
}
