import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/core/theme/app_colors.dart';
import 'package:trendychef/l10n/app_localizations.dart';
import 'package:trendychef/presentation/cart/cubit/cart_cubit.dart';
import 'package:trendychef/presentation/cart/widgets/cart_product_list.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          final cartItems = state.items;
          final itemCount = cartItems.length;

          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      Text(
                        lang.cart,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "($itemCount)",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.fontColor.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),

                // If empty cart
                if (itemCount == 0)
                  Expanded(
                    child: Center(
                      child: Text(
                        "Cart Is Empty",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                // Cart List + Checkout
                if (itemCount > 0)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: CartProductList(cartItems: cartItems, lang: lang),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
