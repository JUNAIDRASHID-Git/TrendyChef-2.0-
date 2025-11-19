import 'package:flutter/material.dart';
import 'package:trendychef/core/theme/app_colors.dart';
import 'package:trendychef/l10n/app_localizations.dart';
import 'package:trendychef/presentation/cart/cart.dart';
import 'package:trendychef/presentation/category/category.dart';
import 'package:trendychef/presentation/home/home.dart';
import 'package:trendychef/presentation/profile/profile.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    CategoryPage(),
    ProfilePage(),
    CartScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _widgetOptions),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(bottom: 10),
        height: 90,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.fontColor.withOpacity(0.15),
              spreadRadius: 2,
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: _buildNavItem(label: "home", title: lang.home, index: 0),
            ),
            Expanded(
              child: _buildNavItem(
                label: "categories",
                title: lang.categories,
                index: 1,
              ),
            ),
            Expanded(
              child: _buildNavItem(
                label: "account",
                title: lang.account,
                index: 2,
              ),
            ),
            Expanded(
              child: _buildNavItem(label: "cart", title: lang.cart, index: 3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required String label,
    required int index,
    required String title,
  }) {
    final bool isSelected = index == _selectedIndex;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              isSelected
                  ? "assets/icons/${label.toLowerCase()}.png"
                  : "assets/icons/${label.toLowerCase()}1.png",
              width: 24,
              height: 24,
              color: isSelected ? AppColors.primary : AppColors.fontColor,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                title,
                style: TextStyle(
                  color: isSelected ? AppColors.primary : AppColors.fontColor,
                  fontSize: 12,
                  fontFamily: "inter",

                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
