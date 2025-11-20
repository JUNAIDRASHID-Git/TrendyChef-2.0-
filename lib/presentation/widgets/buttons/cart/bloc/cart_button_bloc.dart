import 'package:bloc/bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meta/meta.dart';
import 'package:trendychef/core/services/api/cart/delete.dart';
import 'package:trendychef/core/services/api/cart/patch.dart';
import 'package:trendychef/core/services/api/cart/post.dart';
import 'package:trendychef/core/services/models/cart/cart.dart';
import 'package:trendychef/core/services/models/cart/cart_item.dart';

part 'cart_button_event.dart';
part 'cart_button_state.dart';

class CartButtonBloc extends Bloc<CartButtonEvent, CartButtonState> {
  CartButtonBloc() : super(CartButtonInitial()) {
    on<CartAddEvent>((event, emit) async {
      emit(CartButtonLoading());
      try {
        await addToLocalCart(cartItem: event.item);
        emit(CartItemExist(productId: event.item.productId));
      } catch (e) {
        emit(CartButtonError(message: e.toString()));
      }
    });

    on<CartDeleteEvent>((event, emit) async {
      emit(CartButtonLoading());
      try {
        await removeFromLocalCart(productId: event.productID);

        emit(CartItemNotExist(productId: event.productID));
      } catch (e) {
        emit(CartButtonError(message: e.toString()));
      }
    });

    on<CartUpdateQuantityEvent>((event, emit) async {
      emit(CartButtonLoading());

      try {
        await updateItemQuantityInLocalCart(
          productId: event.productID,
          newQuantity: event.quantity,
        );

        emit(
          CartItemQuantityUpdated(
            productId: event.productID,
            quantity: event.quantity,
          ),
        );
        emit(CartItemExist(productId: event.productID));
      } catch (e) {
        emit(CartButtonError(message: e.toString()));
      }
    });

    on<CheckProductExisting>((event, emit) async {
      emit(CartButtonLoading());

      try {
        // Ensure Hive box is open
        if (!Hive.isBoxOpen('cartBox')) {
          await Hive.openBox<CartModel>('cartBox');
        }
        final cartBox = Hive.box<CartModel>('cartBox');

        // Get the cart
        CartModel? cart = cartBox.get('userCart');

        // Check if product exists
        final exists =
            cart?.items.any((item) => item.productId == event.productID) ??
            false;

        if (exists) {
          emit(CartItemExist(productId: event.productID));
        } else {
          emit(CartItemNotExist(productId: event.productID));
        }
      } catch (e) {
        emit(CartButtonError(message: e.toString()));
      }
    });
  }
}
