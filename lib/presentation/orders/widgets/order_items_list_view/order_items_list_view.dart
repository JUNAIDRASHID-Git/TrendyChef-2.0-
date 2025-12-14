import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trendychef/core/services/models/order/order.dart';
import 'package:trendychef/l10n/app_localizations.dart';
import 'package:trendychef/widgets/cards/image.dart';
import 'package:trendychef/widgets/text/sale_price.dart';

class OrderItemListView extends StatelessWidget {
  const OrderItemListView({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    return Expanded(
      child: ListView.builder(
        itemCount: order.items.length,
        itemBuilder: (context, index) {
          final product = order.items[index];

          return GestureDetector(
            onTap: () => context.push("/product/${product.productId}"),
            child: Container(
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 248, 248, 248),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ImageCard(
                    imageUrl: product.productImage,
                    width: 80,
                    height: 80,
                  ),
                  const SizedBox(width: 10),

                  /// Product details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lang.localeName == "en"
                              ? product.productEName
                              : product.productArName,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),

                        SalePriceWidget(
                          salePrice: product.productSalePrice,
                          fontSize: 18,
                        ),
                        const SizedBox(height: 6),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${product.weight} ${lang.kg}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${lang.qty} : ${product.quantity}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
