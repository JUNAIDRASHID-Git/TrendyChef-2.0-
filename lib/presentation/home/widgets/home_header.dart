import 'package:flutter/material.dart';
import 'package:trendychef/core/services/models/user/user.dart';
import 'package:trendychef/l10n/app_localizations.dart';
import 'package:trendychef/widgets/buttons/language/language_selector.dart';
import 'package:trendychef/widgets/icons%20and%20logos/main_logo.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.lang, required this.user});
  final UserModel user;
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
              MainLogo(height: 80),
              SizedBox(width: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${lang.hala} ${user.name}",
                    style: TextStyle(fontSize: 20, fontFamily: "inter"),
                  ),
                  Text(
                    lang.welcometotrendychef,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontFamily: "inter",
                    ),
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
