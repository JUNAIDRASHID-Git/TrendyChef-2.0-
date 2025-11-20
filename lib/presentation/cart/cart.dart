import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/core/theme/app_colors.dart';
import 'package:trendychef/l10n/app_localizations.dart';
import 'package:trendychef/presentation/cart/widgets/bloc/cart_bloc.dart';
import 'package:trendychef/presentation/cart/widgets/cart_product_list.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: SafeArea(
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is CartError) {
              return Center(child: Text('Error: ${state.message}'));
            }

            if (state is CartLoaded) {
              final cartItems = state.cartItems;

              return Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    // Header
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text(
                            'Cart ',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '(${cartItems.length} items)',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.fontColor.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Empty Cart
                    if (cartItems.isEmpty)
                      const Expanded(
                        child: Center(
                          child: Text(
                            'Your cart is empty',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),

                    // Cart Items List
                    if (cartItems.isNotEmpty)
                      CartProductList(cartItems: cartItems, lang: lang),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
