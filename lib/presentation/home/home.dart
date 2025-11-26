import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/l10n/app_localizations.dart';
import 'package:trendychef/presentation/home/bloc/home_bloc.dart';
import 'package:trendychef/presentation/home/widgets/carousel/auto_crousel_slider.dart';
import 'package:trendychef/presentation/home/widgets/category_view.dart';
import 'package:trendychef/presentation/home/widgets/home_header.dart';
import 'package:trendychef/presentation/home/widgets/shimmer.dart';

import 'dart:ui';

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
              if (state is HomeInitial) {
                context.read<HomeBloc>().add(LoadHomeData());
                return const Center(child: CircularProgressIndicator());
              } else if (state is HomeLoading) {
                return const HomeShimmer();
              } else if (state is HomeLoaded) {
                return Column(
                  children: [
                    HomeHeader(lang: lang),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          context.read<HomeBloc>().add(LoadHomeData());
                        },
                        child: CustomScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          slivers: [
                            SliverToBoxAdapter(child: AutoSlidingBanner()),
                            SliverToBoxAdapter(
                                child: CategoryView(state: state, lang: lang)),
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
                        onPressed: () {
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
