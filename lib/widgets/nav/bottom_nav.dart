import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trendychef/core/theme/app_colors.dart';
import 'package:trendychef/l10n/app_localizations.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;

    final String location = GoRouterState.of(context).uri.toString();

    int currentIndex = switch (location) {
      '/home' => 0,
      '/categories' => 1,
      '/account' => 2,
      '/cart' => 3,
      _ => 0,
    };

    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1200),
          child: child,
        ),
      ),
      bottomNavigationBar: Container(
        height: 90,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColors.backGroundColor, width: 0.5),
          ),
        ),
        child: _buildBottomNav(context, currentIndex, lang),
      ),
    );
  }

  Widget _buildBottomNav(
    BuildContext context,
    int currentIndex,
    AppLocalizations lang,
  ) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              _item(
                context,
                label: "home",
                title: lang.home,
                index: 0,
                route: "/home",
                selected: currentIndex == 0,
              ),
              _item(
                context,
                label: "categories",
                title: lang.categories,
                index: 1,
                route: "/categories",
                selected: currentIndex == 1,
              ),
              _item(
                context,
                label: "account",
                title: lang.account,
                index: 2,
                route: "/account",
                selected: currentIndex == 2,
              ),
              _item(
                context,
                label: "cart",
                title: lang.cart,
                index: 3,
                route: "/cart",
                selected: currentIndex == 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _item(
    BuildContext context, {
    required String label,
    required int index,
    required String title,
    required String route,
    required bool selected,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () => context.go(route),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                selected
                    ? "assets/icons/${label.toLowerCase()}.png"
                    : "assets/icons/${label.toLowerCase()}1.png",
                width: 24,
                height: 24,
                color: selected ? AppColors.primary : AppColors.fontColor,
              ),
              Text(
                title,
                style: TextStyle(
                  color: selected ? AppColors.primary : AppColors.fontColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
