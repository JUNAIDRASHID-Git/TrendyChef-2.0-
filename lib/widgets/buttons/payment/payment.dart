import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/core/services/models/cart/cart_item.dart';
import 'package:trendychef/core/services/models/payment/payment.dart';
import 'package:trendychef/core/theme/app_colors.dart';
import 'package:trendychef/l10n/app_localizations.dart';
import 'package:trendychef/presentation/checkout/bloc/checkout_bloc.dart';
import 'package:trendychef/widgets/buttons/payment/bloc/payment_bloc.dart';
import 'package:trendychef/widgets/container/payment_web_view/payment_page_web.dart';
import 'package:trendychef/widgets/text/price.dart';

class PaymentButton extends StatelessWidget {
  const PaymentButton({
    super.key,
    required this.cartItems,
    required this.state,
  });

  final List<CartItemModel> cartItems;
  final CheckoutLoaded state;

  bool _isAddressValid() {
    final address = state.user.address;

    return address.street.isNotEmpty &&
        address.city.isNotEmpty &&
        address.state.isNotEmpty &&
        address.postalCode.isNotEmpty;
  }

  void _showSnack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: TextStyle(
            color: AppColors.backGroundColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        showCloseIcon: true,
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
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
          Expanded(
            child: BlocConsumer<PaymentBloc, PaymentState>(
              listener: (context, paymentstate) {
                if (paymentstate is PaymentLoaded) {
                  log(paymentstate.paymentUrl);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          PaymentPageWeb(url: paymentstate.paymentUrl),
                    ),
                  );

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (_) => PaymentPageMobile(
                  //       paymentUrl: paymentstate.paymentUrl,
                  //     ),
                  //   ),
                  // );
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
                            // VALIDATION CHECKS

                            // 1️⃣ Check cart has items
                            if (cartItems.isEmpty) {
                              _showSnack(context, lang.cartisempty);
                              return;
                            }

                            // 2️⃣ Check user address
                            if (!_isAddressValid()) {
                              _showSnack(
                                context,
                                "Please add a delivery address before payment.",
                              );
                              return;
                            }

                            // 3️⃣ Start Payment
                            final payment = PaymentModel(
                              cartid: cartItems[0].cartId.toString(),
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
                              lang.paynow,
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

          // CART INFO
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "(${cartItems.length}) ${lang.items}",
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
