import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trendychef/presentation/checkout/check_out.dart';

// Screens
import 'package:trendychef/presentation/home/home.dart';
import 'package:trendychef/presentation/category/category.dart';
import 'package:trendychef/presentation/account/account.dart';
import 'package:trendychef/presentation/cart/cart.dart';
import 'package:trendychef/presentation/auth/auth.dart';
import 'package:trendychef/presentation/product/product.dart';
import 'package:trendychef/presentation/search/bloc/search_bloc.dart';
import 'package:trendychef/presentation/search/search.dart';

// Navigation Shell
import 'package:trendychef/widgets/nav/bottom_nav.dart';
import 'package:trendychef/widgets/policy/privacy_policy.dart';
import 'package:trendychef/widgets/policy/return_policy.dart';
import 'package:trendychef/widgets/policy/terms_and_conditions.dart';

final GoRouter router = GoRouter(
  initialLocation: '/home',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return BottomNav(child: child);
      },
      routes: [
        GoRoute(
          path: '/home',
          name: 'home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/categories',
          name: 'categories',
          builder: (context, state) => const CategoryScreen(),
        ),
        GoRoute(
          path: '/account',
          name: 'account',
          builder: (context, state) => const AccountScreen(),
        ),
        GoRoute(
          path: '/cart',
          name: 'cart',
          builder: (context, state) => const CartScreen(),
        ),
      ],
    ),

    GoRoute(
      path: '/checkout',
      name: 'checkout',
      builder: (context, state) => const CheckOutScreen(),
      redirect: (context, state) async {
        final prefs = await SharedPreferences.getInstance();
        final userToken = prefs.getString("idtoken");

        if (userToken == null) {
          return '/auth';
        }

        return null;
      },
    ),

    // Login/auth route
    GoRoute(
      path: '/auth',
      name: 'auth',
      builder: (context, state) => const AuthScreen(), // your auth screen
    ),

    GoRoute(
      path: '/privacy-policy',
      name: 'privacy_policy',
      builder: (context, state) => const PrivacyPolicyScreen(),
    ),

    GoRoute(
      path: '/return-policy',
      name: 'return_policy',
      builder: (context, state) => const ReturnPolicyScreen(),
    ),

    GoRoute(
      path: '/terms-and-conditions',
      name: 'terms_and_conditions',
      builder: (context, state) => const TermsAndConditionsScreen(),
    ),

    GoRoute(
      path: '/search',
      name: 'search',
      builder: (context, state) {
        return BlocProvider(
          create: (_) => SearchBloc()..add(Searching("")),
          child: SearchScreen(),
        );
      },
    ),

    GoRoute(
      path: '/product/:id',
      name: 'product',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        final categoryId = state.uri.queryParameters['categoryId'];

        return ProductScreen(productId: id, categoryId: categoryId);
      },
    ),
  ],
);
