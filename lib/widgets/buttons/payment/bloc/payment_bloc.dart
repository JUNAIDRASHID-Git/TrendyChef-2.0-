import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:trendychef/core/services/api/payment/payment.dart';
import 'package:trendychef/core/services/models/payment/payment.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentInitial()) {
    on<InitPaymentEvent>((event, emit) async {
      emit(PaymentLoading());
      try {
        final paymentUrl = await initPayment(payment: event.paymentData);
        emit(PaymentLoaded(paymentUrl: paymentUrl!));
      } catch (e) {
        emit(PaymentError(error: e.toString()));
      }
    });
  }
}
