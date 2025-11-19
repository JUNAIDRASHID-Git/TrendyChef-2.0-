import 'package:flutter/material.dart';
import 'package:trendychef/core/services/models/cart/cart_item.dart';
import 'package:trendychef/core/services/models/product_model.dart';
import 'package:trendychef/core/theme/app_colors.dart';
import 'package:trendychef/l10n/app_localizations.dart';
import 'package:trendychef/presentation/widgets/buttons/cart/cart.dart';
import 'package:trendychef/presentation/widgets/cards/image.dart';
import 'package:trendychef/presentation/widgets/text/product_name_text.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final List<CartItemModel> items;
  final AppLocalizations lang;

  const ProductCard({
    super.key,
    required this.product,
    required this.lang,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final productName = lang.localeName == "en"
        ? product.eName
        : product.arName ?? "";

    return SizedBox(
      width: 190,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color.fromARGB(80, 238, 238, 238)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImageCard(imageUrl: product.image, width: 180, height: 170),
            Column(
              crossAxisAlignment: .start,
              children: [
                ProductNameText(productName: productName),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: .start,
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

                    CartButton(
                      item: CartItemModel(
                        id: 0,
                        cartId: 1,
                        productId: product.id ?? 0,
                        productImage: product.image,
                        productEName: product.eName,
                        productArName: product.arName,
                        productStock: product.stock,
                        productSalePrice: product.salePrice,
                        productRegularPrice: product.regularPrice,
                        weight: product.weight,
                        quantity: 0,
                        addedAt: DateTime.now(),
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
