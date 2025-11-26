import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/locale_bloc.dart';
import 'package:trendychef/l10n/app_localizations.dart';
import 'package:trendychef/presentation/cart/cubit/cart_cubit.dart';
import 'package:trendychef/presentation/home/bloc/home_bloc.dart';
import 'package:trendychef/presentation/home/home.dart';
import 'package:trendychef/presentation/splash/splash.dart';
import 'presentation/home/widgets/carousel/cubit/carousel_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
            BlocProvider<BannerSliderCubit>(
              create: (_) => BannerSliderCubit()..loadBanners(),
            ),
            BlocProvider(create: (_) => CartCubit()..loadCart()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Trendy Chef',

            // 🔥 Apply selected locale from BLoC
            locale: state.locale,
            supportedLocales: const [Locale('en'), Locale('ar')],

            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],

            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            ),

            home: const SplashScreen(),
            routes: {'/home': (context) => const HomeScreen()},
          ),
        );
      },
    );
  }
}
