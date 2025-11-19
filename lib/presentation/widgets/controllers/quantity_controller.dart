import 'package:flutter/material.dart';
import 'package:trendychef/core/theme/app_colors.dart';

class QuantityController extends StatelessWidget {
  final int quantity;
  const QuantityController({super.key, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children:  [
          Icon(Icons.remove, size: 18),
          SizedBox(width: 8),
          Text(quantity.toString()),
          SizedBox(width: 8),
          Icon(Icons.add, size: 18),
        ],
      ),
    );
  }
}
