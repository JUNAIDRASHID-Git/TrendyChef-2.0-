import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trendychef/core/theme/app_colors.dart';
import 'package:trendychef/l10n/app_localizations.dart';

Widget searchField({
  required BuildContext context,
  required TextEditingController controller,
  required ValueChanged<String> onChanged,
}) {
  final lang = AppLocalizations.of(context)!;

  return ValueListenableBuilder<TextEditingValue>(
    valueListenable: controller,
    builder: (context, value, child) {
      return TextFormField(
        controller: controller,
        onChanged: onChanged,
        style: TextStyle(
          color: AppColors.fontColor,
          fontFamily: "inter",
          fontSize: 18,
        ),
        autofocus: true,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.backGroundColor,
          labelStyle: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
          prefixIcon: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.fontColor,
              size: 18,
            ),
            onPressed: () => context.pop(),
          ),
          hintText: lang.search,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.fontColor.withOpacity(0.1)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: AppColors.fontColor.withOpacity(0.1),
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: AppColors.fontColor.withOpacity(0.1),
              width: 1.5,
            ),
          ),
        ),
      );
    },
  );
}
