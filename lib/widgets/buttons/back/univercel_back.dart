import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trendychef/core/theme/app_colors.dart';

class UniversalBackButton extends StatelessWidget {
  const UniversalBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        final goRouter = GoRouter.maybeOf(context);
        if (goRouter != null && goRouter.canPop()) {
          goRouter.pop();
        } else if (Navigator.canPop(context)) {
          Navigator.of(context).pop();
        } else {
          // optionally do nothing or navigate to a default page
        }
      },
      icon: Icon(
        Icons.arrow_back_ios_new_rounded,
        color: AppColors.fontColor.withOpacity(0.8),
      ),
      style: IconButton.styleFrom(
        backgroundColor: AppColors.fontColor.withOpacity(0.1),
        shape: const CircleBorder(),
      ),
    );
  }
}
