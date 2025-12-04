import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/core/services/models/cart/cart_item.dart';
import 'package:trendychef/core/services/models/payment/payment.dart';
import 'package:trendychef/core/theme/app_colors.dart';
import 'package:trendychef/presentation/checkout/bloc/checkout_bloc.dart';
import 'package:trendychef/widgets/buttons/payment/bloc/payment_bloc.dart';
import 'package:trendychef/widgets/container/payment_web_view/payment_web_view.dart';
import 'package:trendychef/widgets/text/price.dart';

class PaymentButton extends StatelessWidget {
  const PaymentButton({
    super.key,
    required this.cartItems,
    required this.state,
  });

  final List<CartItemModel> cartItems;
  final CheckoutLoaded state;

  @override
  Widget build(BuildContext context) {
    final totalAmount = state.totalAmount + state.shippingCost;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.backGroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Expanded Pay Now button
          Expanded(
            child: BlocConsumer<PaymentBloc, PaymentState>(
              listener: (context, paymentstate) {
                if (paymentstate is PaymentLoaded) {
                  log(paymentstate.paymentUrl);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentWebViewPage(
                        paymentUrl: paymentstate.paymentUrl,
                      ),
                    ),
                  );
                }
              },
              builder: (context, paymentstate) {
                final isLoading = paymentstate is PaymentLoading;
                return Material(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(19),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(19),
                    onTap: isLoading
                        ? null
                        : () {
                            final payment = PaymentModel(
                              cartid: "123",
                              amount: totalAmount,
                              currency: "SAR",
                              description: "Order payment",
                              name: state.user.name,
                              email: state.user.email ?? "TrendyUser@gmail.com",
                              phone: state.user.phone,
                              addressLine1: state.user.address.street,
                              city: state.user.address.city,
                              region: state.user.address.state,
                              postcode: state.user.address.postalCode,
                            );

                            context.read<PaymentBloc>().add(
                              InitPaymentEvent(paymentData: payment),
                            );
                          },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      alignment: Alignment.center,
                      child: isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.5,
                              ),
                            )
                          : Text(
                              "Pay Now",
                              style: TextStyle(
                                color: AppColors.backGroundColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: "noto_sans",
                              ),
                            ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(width: 12),

          // Cart info
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${cartItems.length} Items",
                style: TextStyle(
                  color: AppColors.fontGrey,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              PriceTextWidget(price: totalAmount, fontSize: 18),
            ],
          ),
        ],
      ),
    );
  }
}
