import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/core/services/models/cart/cart_item.dart';
import 'package:trendychef/core/theme/app_colors.dart';
import 'package:trendychef/presentation/cart/bloc/cart_bloc.dart';
import 'package:trendychef/presentation/widgets/buttons/cart/bloc/cart_button_bloc.dart';

class CartButton extends StatelessWidget {
  final CartItemModel item;
  const CartButton({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartButtonBloc, CartButtonState>(
      buildWhen: (prev, curr) => curr is! CartButtonInitial,
      builder: (context, state) {
        /// ---------- LOADING ----------
        if (state is CartButtonLoading) {
          return Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          );
        }

        /// ---------- ERROR ----------
        if (state is CartButtonError) {
          return Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.error, size: 20, color: Colors.red),
          );
        }

        /// ---------- DEFAULT BUTTON ----------
        return Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            splashColor: AppColors.fontColor.withOpacity(0.2),
            highlightColor: Colors.transparent,
            onTap: () {
              context.read<CartButtonBloc>().add(CartAddEvent(item: item));
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Added to cart')));
              context.read<CartBloc>().add(CartFetchEvent());
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Image.asset(
                  'assets/icons/cart.png',
                  width: 20,
                  height: 20,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
