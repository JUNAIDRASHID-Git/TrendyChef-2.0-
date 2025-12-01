import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trendychef/core/theme/app_colors.dart';
import 'package:trendychef/widgets/buttons/google/googlebtn.dart';
import 'package:trendychef/widgets/buttons/text/text.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: Center(
        // centers the constrained width container
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: SafeArea(
            child: Stack(
              children: [
                // TOP-LEFT CLOSE BUTTON (inside the centered layout)
                Positioned(
                  top: 10,
                  left: 10,
                  child: Material(
                    color: Colors.transparent, // keeps your design clean
                    borderRadius: BorderRadius.circular(30),
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
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
                  ),
                ),

                // CENTER MAIN CONTENT
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        "assets/images/trendy_logo.svg",
                        height: 260,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Sign in to continue\nshopping your favorites!",
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
                        const Text("By continuing, you agree to our"),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextButtonWidget(
                              route: "/terms-and-conditions",
                              title: "Terms & Conditions",
                            ),
                            const Text("and"),
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
