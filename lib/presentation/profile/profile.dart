import 'package:flutter/material.dart';
import 'package:trendychef/widgets/buttons/google/googlebtn.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(child: GoogleSignInButton())),
    );
  }
}
