import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trendychef/core/theme/app_colors.dart';
import 'package:trendychef/l10n/app_localizations.dart';
import 'package:trendychef/presentation/account/bloc/account_bloc.dart';
import 'package:trendychef/widgets/cards/order.dart';

class RecentOrderWidget extends StatelessWidget {
  const RecentOrderWidget({super.key, required this.sh, required this.state});
  final AccountLoaded state;
  final double sh;

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    return Container(
      height: sh * 0.64,
      width: double.infinity,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.backGroundColor,
        borderRadius: BorderRadius.circular(19),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(lang.recentorder, style: TextStyle(fontSize: 18)),
          ),
          SizedBox(height: 5),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(19),
              ),
              child: state.recentOrders.isEmpty
                  ? Container(
                      padding: EdgeInsets.all(14),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.backGroundColor,
                        borderRadius: BorderRadius.circular(19),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/images/order.svg",
                                height: 70,
                              ),
                              Text(
                                lang.noorderfound,
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(height: 10),
                              Text(
                                lang.placeanordertoeasilymanageyourpurchases,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.fontGrey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(10),
                      child: ListView.builder(
                        itemCount: state.recentOrders.length,
                        itemBuilder: (context, index) {
                          final order = state.recentOrders[index];
                          return OrderCard(order: order);
                        },
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
