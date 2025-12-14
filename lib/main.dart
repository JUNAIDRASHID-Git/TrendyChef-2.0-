import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/core/const/routing.dart';
import 'package:trendychef/core/theme/app_colors.dart';
import 'package:trendychef/firebase_options.dart';
import 'package:trendychef/locale_bloc.dart';
import 'package:trendychef/l10n/app_localizations.dart';
import 'package:trendychef/presentation/home/bloc/home_bloc.dart';
import 'package:trendychef/widgets/buttons/google/bloc/google_bloc.dart';
import 'package:trendychef/widgets/buttons/payment/bloc/payment_bloc.dart';
import 'package:trendychef/widgets/container/carousel/cubit/carousel_cubit.dart';
import 'package:trendychef/presentation/cart/cubit/cart_cubit.dart';
import 'package:trendychef/presentation/account/bloc/account_bloc.dart';
import 'package:trendychef/presentation/category/bloc/category_bloc.dart';
// ignore: depend_on_referenced_packages
// import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // usePathUrlStrategy();

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
            BlocProvider(create: (_) => HomeBloc()..add(LoadHomeData())),
            BlocProvider(create: (_) => GoogleBloc()),
            BlocProvider(create: (_) => BannerSliderCubit()..loadBanners()),
            BlocProvider(create: (_) => CartCubit()..loadCart()),
            BlocProvider(
              create: (_) => AccountBloc()..add(GetUserDetailEvent()),
            ),
            BlocProvider(create: (_) => PaymentBloc()),
            BlocProvider(
              create: (_) => CategoryBloc()..add(FetchCategoryData()),
            ),
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Trendy Chef',

            // Language
            locale: state.locale,
            supportedLocales: const [Locale('en'), Locale('ar')],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],

            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
              fontFamily: "inter",
            ),

            // 🔥 GoRouter replaces home: and routes:
            routerConfig: router,
          ),
        );
      },
    );
  }
}
