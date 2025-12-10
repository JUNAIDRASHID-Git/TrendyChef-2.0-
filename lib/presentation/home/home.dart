import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/core/theme/app_colors.dart';
import 'package:trendychef/l10n/app_localizations.dart';
import 'package:trendychef/presentation/home/bloc/home_bloc.dart';
import 'package:trendychef/widgets/container/carousel/auto_crousel_slider.dart';
import 'package:trendychef/presentation/home/widgets/category_view.dart';
import 'package:trendychef/presentation/home/widgets/home_header.dart';
import 'package:trendychef/presentation/home/widgets/shimmer.dart';
import 'dart:ui';
import 'package:trendychef/widgets/buttons/search/fake_search.dart';
import 'package:trendychef/widgets/container/error/error_screen.dart';

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
        backgroundColor: AppColors.backGroundColor,
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
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: SizedBox(height: 50, child: FakeSearchButton()),
                    ),
                    SizedBox(height: 15),
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
                return ErrorScreen(error: state.message);
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
