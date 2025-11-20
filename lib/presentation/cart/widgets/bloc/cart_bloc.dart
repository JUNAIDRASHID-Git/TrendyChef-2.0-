import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:trendychef/core/services/api/cart/get.dart';
import 'package:trendychef/core/services/models/cart/cart_item.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartFetchEvent>((event, emit) {
      emit(CartLoading());
      try {
        final cartItems = getCartLocal();
        emit(CartLoaded(cartItems: cartItems));
      } catch (e) {
        emit(CartError(message: e.toString()));
      }
    });
  }
}
