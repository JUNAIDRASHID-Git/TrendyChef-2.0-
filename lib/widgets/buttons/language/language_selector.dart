import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/core/theme/app_colors.dart';
import 'package:trendychef/locale_bloc.dart';

class LanguageSelector extends StatefulWidget {
  final String initial;

  const LanguageSelector({super.key, this.initial = 'en'});

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  OverlayEntry? _entry;
  String lang = 'en';

  final languages = const [
    {"code": "en", "name": "English", "native": "English"},
    {"code": "ar", "name": "Arabic", "native": "العربية"},
  ];

  @override
  void initState() {
    super.initState();
    lang = widget.initial;
  }

  @override
  void dispose() {
    _entry?.remove();
    super.dispose();
  }

  void toggle() {
    if (_entry == null) {
      _showDropdown();
    } else {
      _entry?.remove();
      _entry = null;
    }
  }

  void _showDropdown() {
    final overlay = Overlay.of(context);
    final render = context.findRenderObject() as RenderBox;
    final offset = render.localToGlobal(Offset.zero);

    const dropdownWidth = 160.0;
    const screenMargin = 12.0;

    final screenWidth = MediaQuery.of(context).size.width;

    double left = offset.dx;

    if (left + dropdownWidth > screenWidth - screenMargin) {
      left = screenWidth - dropdownWidth - screenMargin;
    }

    if (left < screenMargin) {
      left = screenMargin;
    }

    _entry = OverlayEntry(
      builder: (_) => Positioned(
        left: left,
        top: offset.dy + render.size.height + 8,
        width: dropdownWidth,
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(12),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: languages.map((e) {
                  final selected = e["code"] == lang;

                  return InkWell(
                    onTap: () {
                      final selectedCode = e["code"]!;
                      setState(() => lang = selectedCode);

                      // 🔥 Update app locale using LocaleCubit
                      context.read<LocaleCubit>().changeLocale(
                        Locale(selectedCode),
                      );

                      toggle();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 14,
                      ),
                      color: selected
                          ? AppColors.primary.withOpacity(.1)
                          : Colors.transparent,
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e["native"]!,
                                  style: const TextStyle(fontSize: 14),
                                ),
                                Text(
                                  e["name"]!,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (selected)
                            Icon(
                              Icons.check_circle,
                              size: 18,
                              color: AppColors.primary,
                            ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(_entry!);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggle,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.language, size: 24, color: Colors.white),
      ),
    );
  }
}
