import 'package:flutter/material.dart';
import 'package:trendychef/core/services/models/order/order.dart';
import 'package:trendychef/l10n/app_localizations.dart';
import 'package:trendychef/widgets/text/sale_price.dart';

class PaymentHistoryOrderSection extends StatelessWidget {
  const PaymentHistoryOrderSection({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    return Container(
      padding: EdgeInsets.all(10),
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 248, 248, 248),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: .spaceBetween,
        crossAxisAlignment: .start,
        children: [
          Text(
            lang.paymentsummary,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(
                lang.shipping,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SalePriceWidget(salePrice: order.shippingCost, fontSize: 16),
            ],
          ),
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(
                lang.total,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SalePriceWidget(salePrice: order.totalAmount, fontSize: 16),
            ],
          ),
        ],
      ),
    );
  }
}
