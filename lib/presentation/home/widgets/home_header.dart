import 'package:flutter/material.dart';
import 'package:trendychef/l10n/app_localizations.dart';
import 'package:trendychef/widgets/buttons/language/language_selector.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.lang});

  final AppLocalizations lang;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("HI, john Doe", style: TextStyle(fontSize: 20)),
                  Text(
                    lang.welcometotrendychef,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          LanguageSelector(),
        ],
      ),
    );
  }
}
