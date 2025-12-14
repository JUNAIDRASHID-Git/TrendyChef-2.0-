import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trendychef/core/theme/app_colors.dart';

class CloseXButton extends StatelessWidget {
  const CloseXButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        onTap: () => context.pop(),
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
    );
  }
}
