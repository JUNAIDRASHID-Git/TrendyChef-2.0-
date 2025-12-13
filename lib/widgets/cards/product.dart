import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trendychef/core/services/models/cart/cart_item.dart';
import 'package:trendychef/core/services/models/product/product_model.dart';
import 'package:trendychef/l10n/app_localizations.dart';
import 'package:trendychef/widgets/buttons/cart/cart.dart';
import 'package:trendychef/widgets/cards/image.dart';
import 'package:trendychef/widgets/text/product_name_text.dart';
import 'package:trendychef/widgets/text/regular_price.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final String? categoryId;

  const ProductCard({super.key, required this.product, this.categoryId});

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    final productName = lang.localeName == "en"
        ? product.eName
        : product.arName ?? "";

    return GestureDetector(
      onTap: () =>
          context.push('/product/${product.id}?categoryId=${categoryId ?? ""}'),
      child: Container(
        width: 190,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color.fromARGB(190, 238, 238, 238)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageCard(imageUrl: product.image, width: 180, height: 170),

            const SizedBox(height: 10),

            SizedBox(
              height: 40,
              child: ProductNameText(productName: productName),
            ),

            const SizedBox(height: 5),

            Row(
              crossAxisAlignment: .start,
              mainAxisAlignment: .spaceBetween,
              children: [
                RegularPriceWidget(
                  regularPrice: product.regularPrice,
                  fontSize: 18,
                ),
                Text("${product.weight} kg"),
              ],
            ),

            const SizedBox(height: 5),

            CartButton(
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
          ],
        ),
      ),
    );
  }
}
