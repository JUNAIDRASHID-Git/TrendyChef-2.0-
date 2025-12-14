import 'package:flutter/material.dart';
import 'package:trendychef/core/services/models/order/order.dart';
import 'package:trendychef/core/theme/app_colors.dart';
import 'package:trendychef/presentation/orders/widgets/header/order_header.dart';
import 'package:trendychef/presentation/orders/widgets/order_items_list_view/order_items_list_view.dart';
import 'package:trendychef/presentation/orders/widgets/order_status_details/order_status_details.dart';
import 'package:trendychef/presentation/orders/widgets/payment_history_section/payment_history_section.dart';

class OrdersScreen extends StatelessWidget {
  final OrderModel order;
  const OrdersScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              SizedBox(height: 10),
              OrderHeader(order: order),
              SizedBox(height: 20),
              OrderStatusDetails(order: order),
              SizedBox(height: 20),
              OrderItemListView(order: order),
              SizedBox(height: 10),
              PaymentHistoryOrderSection(order: order),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
