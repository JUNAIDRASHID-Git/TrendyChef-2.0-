import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/firebase_options.dart';
import 'package:trendychef/locale_bloc.dart';
import 'package:trendychef/l10n/app_localizations.dart';
import 'package:trendychef/Presentation/search/bloc/search_bloc.dart';
import 'package:trendychef/presentation/account/bloc/account_bloc.dart';
import 'package:trendychef/presentation/auth/auth.dart';
import 'package:trendychef/presentation/cart/cart.dart';
import 'package:trendychef/presentation/cart/cubit/cart_cubit.dart';
import 'package:trendychef/presentation/category/category.dart';
import 'package:trendychef/presentation/home/bloc/home_bloc.dart';
import 'package:trendychef/presentation/home/home.dart';
import 'package:trendychef/presentation/account/account.dart';
import 'package:trendychef/presentation/search/search.dart';
import 'package:trendychef/presentation/splash/splash.dart';
import 'package:trendychef/widgets/buttons/google/bloc/google_bloc.dart';
import 'package:trendychef/widgets/policy/privacy_policy.dart';
import 'package:trendychef/widgets/policy/return_policy.dart';
import 'package:trendychef/widgets/policy/terms_and_conditions.dart';
import 'widgets/container/carousel/cubit/carousel_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(BlocProvider(create: (_) => LocaleCubit(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => HomeBloc()),
            BlocProvider(create: (_) => GoogleBloc()),
            BlocProvider(create: (_) => BannerSliderCubit()..loadBanners()),
            BlocProvider(create: (_) => CartCubit()..loadCart()),
            BlocProvider(
              create: (_) => AccountBloc()..add(GetUserDetailEvent()),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Trendy Chef',

            locale: state.locale,
            supportedLocales: const [Locale('en'), Locale('ar')],

            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],

            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            ),

            home: const SplashScreen(),

            routes: {
              '/home': (context) => const HomeScreen(),
              '/categories': (context) => const CategoryScreen(),
              '/account': (context) => const AccountScreen(),
              '/cart': (context) => const CartScreen(),
              '/auth': (context) => const AuthScreen(),
              '/privacy-policy': (context) => const PrivacyPolicyScreen(),
              '/return-policy': (context) => const ReturnPolicyScreen(),
              '/terms-and-conditions': (context) =>
                  const TermsAndConditionsScreen(),
              '/search': (context) => BlocProvider(
                create: (_) => SearchBloc(),
                child: const SearchScreen(),
              ),
            },
          ),
        );
      },
    );
  }
}
