import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/core/theme/app_colors.dart';
import 'package:trendychef/l10n/app_localizations.dart';
import 'package:trendychef/presentation/home/bloc/home_bloc.dart';
import 'package:trendychef/widgets/container/carousel/auto_crousel_slider.dart';
import 'package:trendychef/presentation/home/widgets/category_view.dart';
import 'package:trendychef/presentation/home/widgets/home_header.dart';
import 'package:trendychef/presentation/home/widgets/shimmer.dart';
import 'package:trendychef/widgets/buttons/search/fake_search.dart';
import 'package:trendychef/widgets/container/error/error_screen.dart';

final class WebScrollBehavior extends MaterialScrollBehavior {
  const WebScrollBehavior();

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
    return const ScrollConfiguration(
      behavior: WebScrollBehavior(),
      child: Scaffold(
        backgroundColor: AppColors.backGroundColor,
        body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(builder: _buildBody),
        ),
      ),
    );
  }

  static Widget _buildBody(BuildContext context, HomeState state) {
    final lang = AppLocalizations.of(context)!;

    if (state is HomeLoading) {
      return const HomeShimmer();
    }

    if (state is HomeError) {
      return ErrorScreen(error: state.message);
    }

    if (state is HomeLoaded) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 5),
          HomeHeader(lang: lang, user: state.user),
          const SizedBox(height: 5),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(height: 50, child: FakeSearchButton()),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<HomeBloc>().add(LoadHomeData());
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    AutoSlidingBanner(banners: state.banners),
                    const SizedBox(height: 15),
                    CategoryView(state: state, lang: lang),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }

    return const SizedBox.shrink();
  }
}
