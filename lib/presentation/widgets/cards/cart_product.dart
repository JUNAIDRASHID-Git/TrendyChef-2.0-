import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/core/services/api/cart/delete.dart';
import 'package:trendychef/core/services/models/cart/cart_item.dart';
import 'package:trendychef/core/theme/app_colors.dart';
import 'package:trendychef/l10n/app_localizations.dart';
import 'package:trendychef/presentation/cart/bloc/cart_bloc.dart';
import 'package:trendychef/presentation/widgets/buttons/delete/delete.dart';
import 'package:trendychef/presentation/widgets/cards/image.dart';
import 'package:trendychef/presentation/widgets/text/product_name_text.dart';

class CartProductCard extends StatelessWidget {
  final CartItemModel product;
  final AppLocalizations lang;

  const CartProductCard({super.key, required this.product, required this.lang});

  @override
  Widget build(BuildContext context) {
    final productName = lang.localeName == "en"
        ? product.productEName
        : product.productArName ?? "";

    return Container(
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
          /// ---------- PRODUCT IMAGE ----------
          Row(
            children: [
              ImageCard(
                imageUrl: product.productImage ?? "",
                width: 150, // Responsive width
                height: 140,
              ),
              const SizedBox(width: 12),

              /// ---------- PRODUCT INFO + ACTIONS ----------
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
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 5),

          /// ---------- QUANTITY + DELETE ----------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.remove, size: 18),
                      SizedBox(width: 8),
                      Text("1"),
                      SizedBox(width: 8),
                      Icon(Icons.add, size: 18),
                    ],
                  ),
                ),
              ),

              DeleteButton(
                onTap: () {
                  removeFromLocalCart(productId: product.id);
                  context.read<CartBloc>().add(CartFetchEvent());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
