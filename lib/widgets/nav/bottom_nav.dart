import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:trendychef/core/theme/app_colors.dart';
import 'package:trendychef/l10n/app_localizations.dart';
import 'package:trendychef/presentation/account/account.dart';
import 'package:trendychef/presentation/cart/cart.dart';
import 'package:trendychef/presentation/category/category.dart';
import 'package:trendychef/presentation/home/home.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key, required this.child});

  final Widget child;

  int _locationToIndex(String location) {
    switch (location) {
      case '/home':
        return 0;
      case '/categories':
        return 1;
      case '/account':
        return 2;
      case '/cart':
        return 3;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final currentIndex = _locationToIndex(location);

    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      // Wrap body in Center + ConstrainedBox to limit max width
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: IndexedStack(
            index: currentIndex,
            children: const [
              HomeScreen(),
              CategoryScreen(),
              AccountScreen(),
              CartScreen(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const _BottomNavBar(),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar();

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    final location = GoRouterState.of(context).uri.path;

    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: AppColors.backGroundColor,
        border: Border(
          top: BorderSide(
            color: AppColors.fontColor.withOpacity(0.1),
            width: 0.5,
          ),
        ),
      ),
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BottomNavItem(
                  label: 'home',
                  title: lang.home,
                  route: '/home',
                  selected: location == '/home',
                ),
                BottomNavItem(
                  label: 'category',
                  title: lang.categories,
                  route: '/categories',
                  selected: location == '/categories',
                ),
                BottomNavItem(
                  label: 'profile',
                  title: lang.account,
                  route: '/account',
                  selected: location == '/account',
                ),
                BottomNavItem(
                  label: 'cart',
                  title: lang.cart,
                  route: '/cart',
                  selected: location == '/cart',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// =======================
/// Bottom Nav Item
/// =======================
class BottomNavItem extends StatelessWidget {
  const BottomNavItem({
    super.key,
    required this.label,
    required this.title,
    required this.route,
    required this.selected,
  });

  final String label;
  final String title;
  final String route;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final Color color = selected ? AppColors.primary : AppColors.fontColor;

    final String iconPath = selected
        ? 'assets/icons/$label.svg'
        : 'assets/icons/${label}1.svg';

    return InkWell(
      onTap: () {
        if (!selected) {
          context.go(route);
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
