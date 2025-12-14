import 'package:flutter/material.dart';
import 'package:trendychef/core/theme/app_colors.dart';
import 'package:trendychef/l10n/app_localizations.dart';
import 'package:trendychef/widgets/buttons/close/close.dart';
import 'package:trendychef/widgets/buttons/google/googlebtn.dart';
import 'package:trendychef/widgets/buttons/text/text.dart';
import 'package:trendychef/widgets/icons%20and%20logos/main_logo.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: SafeArea(
            child: Stack(
              children: [
                Positioned(top: 10, left: 10, child: CloseXButton()),

                // CENTER MAIN CONTENT
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MainLogo(height: 260),
                      const SizedBox(height: 20),
                      Text(
                        lang.signintocontinue,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color.fromARGB(255, 1, 95, 86),
                          fontFamily: "inter",
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(width: 280, child: GoogleSignInButton()),
                    ],
                  ),
                ),

                // BOTTOM TERMS & POLICY
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(lang.bycontinuingyouagreetoour),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextButtonWidget(
                              route: "/terms-and-conditions",
                              title: "Terms & Conditions",
                            ),
                            Text(lang.and),
                            TextButtonWidget(
                              route: "/privacy-policy",
                              title: "Privacy Policy",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


