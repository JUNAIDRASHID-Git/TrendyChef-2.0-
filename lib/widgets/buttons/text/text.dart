import 'package:flutter/material.dart';
import 'package:trendychef/core/theme/app_colors.dart';

class TextButtonWidget extends StatelessWidget {
  const TextButtonWidget({
    super.key,
    required this.title,
    required this.route,
    this.color,
  });
  final String title;
  final String route;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      child: Text(
        title,
        style: TextStyle(
          color: color ?? AppColors.bluefont,
          fontFamily: "inter",
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
