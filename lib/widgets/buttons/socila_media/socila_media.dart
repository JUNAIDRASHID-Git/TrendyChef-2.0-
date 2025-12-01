import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trendychef/core/theme/app_colors.dart';

class SocilaMediaButton extends StatelessWidget {
  const SocilaMediaButton({super.key, required this.iconSvgPath, this.onTap});
  final String iconSvgPath;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        splashColor: Colors.grey.withOpacity(0.3),
        child: Container(
          height: 50,
          width: 50,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: SvgPicture.asset(
            iconSvgPath,
            color: AppColors.fontColor.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
