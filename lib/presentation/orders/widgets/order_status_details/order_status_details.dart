import 'package:flutter/material.dart';
import 'package:trendychef/core/services/models/order/order.dart';
import 'package:trendychef/core/theme/app_colors.dart';
import 'package:trendychef/core/theme/order_status.dart';
import 'package:trendychef/l10n/app_localizations.dart';

class OrderStatusDetails extends StatelessWidget {
  const OrderStatusDetails({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    DateTime createdAt = order.createdAt;

    String formattedDate =
        '${createdAt.day}-${createdAt.month}-${createdAt.year}';
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(
            "${lang.dateoforder} : $formattedDate",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.fontGrey,
            ),
          ),
          Row(
            children: [
              Text(
                "${lang.paymentstatus} : ${order.paymentStatus.toUpperCase()}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.fontGrey,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "${lang.orderstatus} : ",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.fontGrey,
                ),
              ),
              buildStatusChip(order.status, context),
            ],
          ),
        ],
      ),
    );
  }
}
