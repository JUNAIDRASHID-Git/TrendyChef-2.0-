import 'package:flutter/material.dart';
import 'package:trendychef/core/theme/app_colors.dart';

class FakeSearchButton extends StatelessWidget {
  const FakeSearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, "/search"),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.backGroundColor,
          border: Border.all(
            color: AppColors.fontColor.withOpacity(0.1),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              Icons.search,
              size: 28,
              color: AppColors.fontColor.withOpacity(0.8),
            ),
            const SizedBox(width: 10),
            Text(
              "serach",
              style: TextStyle(
                color: AppColors.fontColor.withOpacity(0.8),
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
