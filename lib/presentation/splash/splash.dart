import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trendychef/core/services/api/user/create_guest.dart';
import 'package:trendychef/widgets/nav/bottom_nav.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _fade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();

    initGuestUserFlow();
  }

  /// -----------------------------
  /// GUEST USER FLOW STARTS HERE
  /// -----------------------------
 Future<void> initGuestUserFlow() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? guestId = prefs.getString("guest_id");
  String? userToken = prefs.getString("idtoken");

  // If guest already exists OR user is logged in → go to BottomNav
  if (guestId != null || userToken != null) {
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BottomNav()),
      );
    });
    return;
  }

  // No guest + no user → create guest
  guestId = await createGuestUser();

  if (guestId != null) {
    await prefs.setString("guest_id", guestId);
  }

  Future.delayed(const Duration(seconds: 2), () {
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const BottomNav()),
    );
  });
}


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FadeTransition(
        opacity: _fade,
        child: Center(
          child: SvgPicture.asset(
            'assets/images/trendy_logo.svg',
            width: 250,
            height: 250,
          ),
        ),
      ),
    );
  }
}
