import 'package:flutter/material.dart';
import 'package:trendychef/core/theme/app_colors.dart';
import 'package:trendychef/presentation/checkout/bloc/checkout_bloc.dart';
import 'package:trendychef/widgets/text/price.dart';

class PaymentSummarySection extends StatelessWidget {
  final CheckoutLoaded state;
  const PaymentSummarySection({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.backGroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Summary",
            style: TextStyle(
              fontSize: 18,
              color: AppColors.fontColor,
              fontWeight: FontWeight.w900,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Subtotal",
                style: TextStyle(
                  color: AppColors.fontGrey,
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                ),
              ),
              PriceTextWidget(
                price: state.totalAmount,
                regularPrice: state.totalRegularAmount,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Shipping Fee",
                style: TextStyle(
                  color: AppColors.fontGrey,
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                ),
              ),
              PriceTextWidget(price: state.shippingCost),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Total",
                    style: TextStyle(
                      color: AppColors.fontColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Incl. VAT",
                    style: TextStyle(
                      color: AppColors.fontGrey,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              PriceTextWidget(
                price: state.totalAmount + state.shippingCost,
                fontSize: 18,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
