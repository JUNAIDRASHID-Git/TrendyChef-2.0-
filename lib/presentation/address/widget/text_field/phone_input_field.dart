import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trendychef/core/theme/app_colors.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? error;
  final String? hint;
  final ValueChanged<String> onChanged;
  final TextInputType keyboardType;
  final String? prefix;

  final bool isPhone; // validates phone
  final bool isPostal; // validates postal number only

  final int maxLines;
  final bool expandable;

  const TextInputField({
    super.key,
    required this.controller,
    required this.label,
    required this.onChanged,
    this.error,
    this.hint,
    this.keyboardType = TextInputType.text,
    this.prefix,
    this.isPhone = false,
    this.isPostal = false,
    this.maxLines = 1,
    this.expandable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 18)),
          const SizedBox(height: 5),

          Container(
            constraints: expandable
                ? const BoxConstraints(minHeight: 55)
                : const BoxConstraints.tightFor(height: 55),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.backGroundColor,
              borderRadius: BorderRadius.circular(19),
            ),

            child: TextField(
              controller: controller,
              keyboardType: isPhone || isPostal
                  ? TextInputType.number
                  : keyboardType,

              inputFormatters: [
                if (isPhone || isPostal) FilteringTextInputFormatter.digitsOnly,
                if (isPhone)
                  LengthLimitingTextInputFormatter(9), // phone max 9 digits
              ],

              onChanged: onChanged,
              maxLines: expandable ? null : maxLines,
              minLines: expandable ? 1 : maxLines,

              textAlignVertical: TextAlignVertical.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),

              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 16),

                filled: true,
                fillColor: AppColors.backGroundColor,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),

                prefixIcon: prefix != null
                    ? Padding(
                        padding: const EdgeInsets.only(left: 12, right: 6),
                        child: Text(
                          prefix!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    : null,

                prefixIconConstraints: const BoxConstraints(
                  minWidth: 0,
                  minHeight: 0,
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(19),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // error text
          if (error != null)
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 4),
              child: Text(
                error!,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
