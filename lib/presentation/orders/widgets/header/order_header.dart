import 'package:flutter/material.dart';
import 'package:trendychef/core/services/models/order/order.dart';
import 'package:trendychef/core/theme/app_colors.dart';
import 'package:trendychef/l10n/app_localizations.dart';

class OrderHeader extends StatelessWidget {
  const OrderHeader({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        Row(
          children: [
            Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(30),
              child: InkWell(
                onTap: () => Navigator.pop(context),
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.fontColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Icon(Icons.close),
                ),
              ),
            ),
            SizedBox(width: 20),
            Text(
              "# ${order.id.toString()}",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Text(
          "${lang.items} (${order.items.length})",
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
