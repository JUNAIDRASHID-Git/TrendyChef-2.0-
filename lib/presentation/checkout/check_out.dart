import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/core/theme/app_colors.dart';
import 'package:trendychef/l10n/app_localizations.dart';
import 'package:trendychef/presentation/checkout/bloc/checkout_bloc.dart';
import 'package:trendychef/widgets/buttons/location/location.dart';
import 'package:trendychef/widgets/buttons/payment/payment.dart';
import 'package:trendychef/widgets/text/price.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: BlocProvider(
        create: (context) => CheckoutBloc()..add(FetchDataCheckoutEvent()),
        child: BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            if (state is CheckoutLoaded) {
              final user = state.user;
              final cartItems = state.cartItems;
              return SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.arrow_back_ios_new_rounded),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Checkout",
                          style: TextStyle(
                            color: AppColors.fontColor,
                            fontFamily: "inter",
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                    LocationButton(user: user),
                    SizedBox(height: 10),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        padding: EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.backGroundColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: .start,
                          children: [
                            Text(
                              "${cartItems.length} items",
                              style: TextStyle(
                                fontSize: 18,
                                letterSpacing: 1.5,
                                color: AppColors.fontGrey,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(height: 10),
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: cartItems.length,
                                itemBuilder: (context, index) {
                                  final item = cartItems[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      crossAxisAlignment: .center,
                                      children: [
                                        Image.network(
                                          item.productImage,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                                return Container(
                                                  width: 100,
                                                  height: 100,
                                                  color: Colors.grey.shade300,
                                                  alignment: Alignment.center,
                                                  child: const Icon(
                                                    Icons.broken_image,
                                                    color: Colors.grey,
                                                    size: 30,
                                                  ),
                                                );
                                              },
                                        ),

                                        const SizedBox(width: 10),

                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              lang.localeName == "en"
                                                  ? item.productEName
                                                  : item.productArName,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            PriceTextWidget(
                                              price: item.productSalePrice,
                                              fontSize: 18,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Delivery with in (1-5 Days)",
                              style: TextStyle(
                                fontSize: 18,
                                letterSpacing: 1.5,
                                color: AppColors.fontGrey,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 10),

                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      padding: EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.backGroundColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: .start,
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
                            mainAxisAlignment: .spaceBetween,
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
                            mainAxisAlignment: .spaceBetween,
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
                            mainAxisAlignment: .spaceBetween,
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
                    ),

                    SizedBox(height: 10),

                    PaymentButton(cartItems: cartItems, state: state),

                    Container(height: 40, color: AppColors.backGroundColor),
                  ],
                ),
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
