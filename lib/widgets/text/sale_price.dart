import 'package:flutter/material.dart';

class SalePriceWidget extends StatelessWidget {
  final double salePrice;
  final double fontSize;
  final Color? fontColor;
  const SalePriceWidget({
    super.key,
    required this.salePrice,
    required this.fontSize,
    this.fontColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: .start,
      children: [
        Image.asset(
          "assets/images/riyal_logo.png",
          color: fontColor,
          height: fontSize,
        ),
        const SizedBox(width: 5),
        Text(
          salePrice.toStringAsFixed(2),
          style: TextStyle(
            fontSize: fontSize,
            fontFamily: "noto_sans",
            color: fontColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
