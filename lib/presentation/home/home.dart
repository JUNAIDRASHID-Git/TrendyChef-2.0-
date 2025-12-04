import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trendychef/core/theme/app_colors.dart';
import 'package:trendychef/l10n/app_localizations.dart';
import 'package:trendychef/presentation/account/bloc/account_bloc.dart';
import 'package:trendychef/presentation/cart/cubit/cart_cubit.dart';
import 'package:trendychef/presentation/home/bloc/home_bloc.dart';
import 'package:trendychef/widgets/container/carousel/auto_crousel_slider.dart';
import 'package:trendychef/presentation/home/widgets/category_view.dart';
import 'package:trendychef/presentation/home/widgets/home_header.dart';
import 'package:trendychef/presentation/home/widgets/shimmer.dart';
import 'dart:ui';
import 'package:trendychef/widgets/buttons/search/fake_search.dart';

class WebScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.mouse,
    PointerDeviceKind.touch,
    PointerDeviceKind.trackpad,
    PointerDeviceKind.stylus,
  };
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;

    return ScrollConfiguration(
      behavior: WebScrollBehavior(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return const HomeShimmer();
              } else if (state is HomeLoaded) {
                return Column(
                  children: [
                    SizedBox(height: 5),
                    HomeHeader(lang: lang, user: state.user),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: FakeSearchButton(),
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: AppColors.backGroundColor,
                              border: Border.all(
                                color: AppColors.fontColor.withOpacity(0.1),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: AppColors.fontColor.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          context.read<HomeBloc>().add(LoadHomeData());
                        },
                        child: CustomScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          slivers: [
                            SliverToBoxAdapter(child: AutoSlidingBanner()),
                            SliverToBoxAdapter(child: SizedBox(height: 10)),
                            SliverToBoxAdapter(
                              child: CategoryView(state: state, lang: lang),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else if (state is HomeError) {
                return Center(
                  child: Column(
                    children: [
                      Text(state.message),
                      ElevatedButton(
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.clear();
                          context.read<AccountBloc>().add(GetUserDetailEvent());
                          context.read<CartCubit>().loadCart();
                          context.read<HomeBloc>().add(LoadHomeData());
                        },
                        child: Text("Refresh"),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
