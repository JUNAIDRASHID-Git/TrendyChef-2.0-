import 'package:flutter/material.dart';
import 'package:trendychef/core/theme/app_colors.dart';

class PriceTextWidget extends StatelessWidget {
  const PriceTextWidget({
    super.key,
    required this.price,
    this.regularPrice,
    this.fontSize = 14,
  });

  final double price;

  final double? regularPrice;

  final double fontSize;

  bool get isDiscounted => regularPrice != null && regularPrice! > price;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // regular Price (if discounted)
        if (isDiscounted)
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: Row(
              children: [
                Text(
                  regularPrice!.toStringAsFixed(2),
                  style: TextStyle(
                    fontSize: fontSize,
                    fontFamily: "noto_sans",
                    color: AppColors.fontColor.withOpacity(0.5),
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ),
          ),

        // Current Price
        Row(
          crossAxisAlignment: .start,
          children: [
            Image.asset(
              "assets/images/riyal_logo.png",
              color: AppColors.fontColor,
              height: fontSize-1,
            ),
            const SizedBox(width: 5),
            Text(
              price.toStringAsFixed(2),
              style: TextStyle(
                fontSize: fontSize,
                fontFamily: "noto_sans",
                color: AppColors.fontColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
