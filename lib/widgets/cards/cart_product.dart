import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trendychef/core/services/models/cart/cart_item.dart';
import 'package:trendychef/core/theme/app_colors.dart';
import 'package:trendychef/l10n/app_localizations.dart';
import 'package:trendychef/presentation/cart/cubit/cart_cubit.dart';
import 'package:trendychef/widgets/buttons/delete/delete.dart';
import 'package:trendychef/widgets/cards/image.dart';
import 'package:trendychef/widgets/controllers/quantity/quantity_controller.dart';
import 'package:trendychef/widgets/text/product_name_text.dart';

class CartProductCard extends StatelessWidget {
  final CartItemModel product;
  final AppLocalizations lang;

  const CartProductCard({super.key, required this.product, required this.lang});

  @override
  Widget build(BuildContext context) {
    final productName = lang.localeName == "en"
        ? product.productEName
        : product.productArName;

    return InkWell(
      onTap: () => context.push("/product/${product.productId}"),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.fontColor.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(12),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ImageCard(
                  imageUrl: product.productImage,
                  width: 140, // Responsive width
                  height: 140,
                ),
                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Product Title
                      ProductNameText(productName: productName),
                      const SizedBox(height: 6),

                      /// Old Price
                      Text(
                        "${product.productRegularPrice.toStringAsFixed(2)} SAR",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.fontColor.withOpacity(0.6),
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),

                      /// New Price
                      Text(
                        "${product.productSalePrice.toStringAsFixed(2)} SAR",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AppColors.fontColor,
                        ),
                      ),
                      SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          QuantityControllerWidget(
                            productId: product.productId,
                            height: 30,
                            width: 80,
                          ),

                          DeleteButton(
                            onTap: () {
                              final cubit = context.read<CartCubit>();
                              cubit.removeFromCart(product.productId);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
