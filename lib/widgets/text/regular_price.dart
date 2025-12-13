import 'package:flutter/material.dart';
import 'package:trendychef/core/theme/app_colors.dart';

class RegularPriceWidget extends StatelessWidget {
  final double regularPrice;
  final double fontSize;
  const RegularPriceWidget({
    super.key,
    required this.regularPrice,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: Row(
        children: [
          Text(
            regularPrice.toStringAsFixed(2),
            style: TextStyle(
              fontSize: fontSize,
              fontFamily: "noto_sans",
              color: AppColors.fontColor.withOpacity(0.5),
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ),
    );
  }
}
