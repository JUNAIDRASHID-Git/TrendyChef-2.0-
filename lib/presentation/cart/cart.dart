import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:trendychef/core/theme/app_colors.dart';
import 'package:trendychef/l10n/app_localizations.dart';
import 'package:trendychef/presentation/cart/cubit/cart_cubit.dart';
import 'package:trendychef/presentation/cart/widgets/cart_product_list.dart';
import 'package:trendychef/presentation/cart/widgets/check_out_expanding_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isCheckoutExpanded = false;

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          final items = state.items;

          return Stack(
            children: [
              // MAIN PAGE CONTENT INSIDE SAFE AREA
              SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Row(
                        children: [
                          Text(
                            lang.cart,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "(${items.length} Items)",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.fontColor.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    Expanded(
                      child: items.isEmpty
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 350,
                                      child: LottieBuilder.asset(
                                        "assets/lottie/empty_cart.json",
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // Main text with styling
                                        Text(
                                          "Cart Is Empty",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.fontColor
                                                .withOpacity(0.7),
                                          ),
                                        ),

                                        const SizedBox(width: 8),
                                      ],
                                    ),
                                    SizedBox(height: 100),
                                  ],
                                ),
                              ],
                            )
                          : Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              color: AppColors.fontColor.withOpacity(0.05),
                              child: CartProductList(
                                cartItems: items,
                                lang: lang,
                              ),
                            ),
                    ),
                  ],
                ),
              ),

              // ==== FADE OVERLAY ON TOP OF EVERYTHING ====
              IgnorePointer(
                ignoring: !isCheckoutExpanded,
                child: AnimatedOpacity(
                  opacity: isCheckoutExpanded ? 0.45 : 0.0,
                  duration: const Duration(milliseconds: 250),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.black,
                  ),
                ),
              ),

              // ==== CHECKOUT WIDGET ====
              if (items.isNotEmpty)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CheckOutExpandingWidget(
                    state: state,
                    onExpandChanged: (value) {
                      setState(() => isCheckoutExpanded = value);
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
