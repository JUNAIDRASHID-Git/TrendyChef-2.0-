import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:trendychef/core/services/api/cart/post.dart';
import 'package:trendychef/core/services/models/cart/cart_item.dart';

part 'cart_button_event.dart';
part 'cart_button_state.dart';

class CartButtonBloc extends Bloc<CartButtonEvent, CartButtonState> {
  CartButtonBloc() : super(CartButtonInitial()) {
    on<CartAddEvent>((event, emit) {
      emit(CartButtonLoading());
      try {
         
        addToLocalCart(cartItem: event.item);
        emit(CartButtonLoaded(isItemExist: true));
      } catch (e) {
        emit(CartButtonError());
      }
    });
  }
}
