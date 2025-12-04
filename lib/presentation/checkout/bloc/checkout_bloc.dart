import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:trendychef/core/services/api/cart/get.dart';
import 'package:trendychef/core/services/api/user/get.dart';
import 'package:trendychef/core/services/models/cart/cart_item.dart';
import 'package:trendychef/core/services/models/user/user.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(CheckoutInitial()) {
    on<FetchDataCheckoutEvent>((event, emit) async {
      emit(CheckoutLoading());
      try {
        final user = await getUser();
        final cartItems = await getCartItems();
        emit(CheckoutLoaded(user: user, cartItems: cartItems));
      } catch (e) {
        emit(CheckoutError(error: e.toString()));
      }
    });
  }
}
