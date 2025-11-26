import 'package:flutter/material.dart';
import 'package:trendychef/core/theme/app_colors.dart';

class ProductNameText extends StatelessWidget {
  const ProductNameText({super.key, required this.productName});

  final String productName;

  @override
  Widget build(BuildContext context) {
    return Text(
      productName,
      style: const TextStyle(
        fontFamily: "inter",
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: AppColors.fontColor,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
