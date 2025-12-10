import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trendychef/l10n/app_localizations.dart';
import 'package:trendychef/presentation/account/bloc/account_bloc.dart';
import 'package:trendychef/presentation/cart/cubit/cart_cubit.dart';
import 'package:trendychef/presentation/category/bloc/category_bloc.dart';
import 'package:trendychef/presentation/home/bloc/home_bloc.dart';

class ErrorScreen extends StatelessWidget {
  final String error;
  const ErrorScreen({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 300,
                child: LottieBuilder.asset(
                  "assets/lottie/No Internet Animation.json",
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                error,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              FilledButton.icon(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.clear();
                  context.read<AccountBloc>().add(GetUserDetailEvent());
                  context.read<CategoryBloc>().add(FetchCategoryData());
                  context.read<CartCubit>().loadCart();
                  context.read<HomeBloc>().add(LoadHomeData());
                },
                icon: const Icon(Icons.refresh_rounded, size: 25),
                label: Text(
                  lang.tryagain,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 42,
                    vertical: 26,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
