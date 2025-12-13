import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trendychef/core/theme/app_colors.dart';

class DeleteButton extends StatelessWidget {
  final VoidCallback onTap;

  const DeleteButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        splashColor: AppColors.fontColor.withOpacity(0.2),
        highlightColor: AppColors.fontColor.withOpacity(0.1),

        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.fontColor.withOpacity(0.2)),
          ),
          child: SvgPicture.asset(
            'assets/icons/trash.svg',
            width: 22,
            height: 22,
            color: AppColors.fontColor,
          ),
        ),
      ),
    );
  }
}
