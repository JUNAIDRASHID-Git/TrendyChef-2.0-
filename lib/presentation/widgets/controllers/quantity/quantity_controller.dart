import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/core/theme/app_colors.dart';
import 'package:trendychef/presentation/cart/widgets/bloc/cart_bloc.dart';
import 'package:trendychef/presentation/widgets/buttons/cart/bloc/cart_button_bloc.dart';

class QuantityController extends StatelessWidget {
  final int quantity;
  final int productId;
  final int stock;

  const QuantityController({
    super.key,
    required this.quantity,
    required this.productId,
    required this.stock,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartButtonBloc, CartButtonState>(
      buildWhen: (previous, current) {
        return current is CartItemQuantityUpdated &&
            current.productId == productId;
      },
      builder: (context, state) {
        int currentQuantity = quantity;

        if (state is CartItemQuantityUpdated && state.productId == productId) {
          currentQuantity = state.quantity;
        }

        return Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ------ DECREASE ------
                InkWell(
                  borderRadius: BorderRadius.circular(4),
                  onTap: currentQuantity > 1
                      ? () {
                          context.read<CartButtonBloc>().add(
                            CartUpdateQuantityEvent(
                              productID: productId,
                              quantity: currentQuantity - 1,
                            ),
                          );
                          context.read<CartBloc>().add(CartFetchEvent());
                        }
                      : null, // disabled when quantity = 1
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Icon(
                      Icons.remove,
                      size: 14,
                      color: currentQuantity > 1
                          ? AppColors.fontColor
                          : Colors.grey.shade400,
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                // ------ QUANTITY ------
                Text(
                  "$currentQuantity",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(width: 8),

                // ------ INCREASE ------
                InkWell(
                  borderRadius: BorderRadius.circular(4),
                  onTap: currentQuantity < stock
                      ? () {
                          context.read<CartButtonBloc>().add(
                            CartUpdateQuantityEvent(
                              productID: productId,
                              quantity: currentQuantity + 1,
                            ),
                          );
                          context.read<CartBloc>().add(CartFetchEvent());
                        }
                      : null, // disabled when quantity reaches stock
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Icon(
                      Icons.add,
                      size: 14,
                      color: currentQuantity < stock
                          ? AppColors.fontColor
                          : Colors.grey.shade400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
