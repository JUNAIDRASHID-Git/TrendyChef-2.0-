import 'package:flutter/material.dart';
import 'package:trendychef/core/services/models/cart/cart_item.dart';
import 'package:trendychef/core/services/models/product/product_model.dart';
import 'package:trendychef/core/theme/app_colors.dart';
import 'package:trendychef/l10n/app_localizations.dart';
import 'package:trendychef/widgets/buttons/cart/cart.dart';
import 'package:trendychef/widgets/cards/image.dart';
import 'package:trendychef/widgets/text/product_name_text.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    final productName = lang.localeName == "en"
        ? product.eName
        : product.arName ?? "";

    return SizedBox(
      width: 190,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color.fromARGB(80, 238, 238, 238)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ----------------------------------------
            // STACK: Image + CartButton positioned
            // ----------------------------------------
            Stack(
              children: [
                ImageCard(imageUrl: product.image, width: 180, height: 170),

                Positioned(
                  bottom: 6,
                  right: 6,
                  child: CartButton(
                    item: CartItemModel(
                      id: product.id!,
                      cartId: 1,
                      productId: product.id!,
                      productImage: product.image,
                      productEName: product.eName,
                      productArName: product.arName ?? product.eName,
                      stock: product.stock,
                      productSalePrice: product.salePrice,
                      productRegularPrice: product.regularPrice,
                      weight: product.weight,
                      quantity: 1,
                      addedAt: DateTime.now(),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Product name
            ProductNameText(productName: productName),

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${product.regularPrice.toStringAsFixed(2)} SAR',
                      style: const TextStyle(
                        fontFamily: "noto_sans",
                        fontSize: 14,
                        color: AppColors.fontColor,
                      ),
                    ),
                    Text(
                      '${product.salePrice.toStringAsFixed(2)} SAR',
                      style: const TextStyle(
                        fontFamily: "noto_sans",
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppColors.fontColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
