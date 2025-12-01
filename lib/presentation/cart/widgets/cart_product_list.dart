import 'package:flutter/material.dart';
import 'package:trendychef/core/services/models/cart/cart_item.dart';
import 'package:trendychef/l10n/app_localizations.dart';
import 'package:trendychef/widgets/cards/cart_product.dart';

class CartProductList extends StatelessWidget {
  const CartProductList({
    super.key,
    required this.cartItems,
    required this.lang,
  });

  final List<CartItemModel> cartItems;
  final AppLocalizations lang;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        final item = cartItems[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: CartProductCard(product: item, lang: lang),
        );
      },
    );
  }
}
