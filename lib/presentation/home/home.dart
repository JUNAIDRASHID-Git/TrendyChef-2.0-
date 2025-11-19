import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/l10n/app_localizations.dart';
import 'package:trendychef/presentation/home/bloc/home_bloc.dart';
import 'package:trendychef/presentation/home/widgets/banner/banner_slider.dart';
import 'package:trendychef/presentation/home/widgets/category_view.dart';
import 'package:trendychef/presentation/home/widgets/home_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeInitial) {
              context.read<HomeBloc>().add(LoadHomeData());
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeLoaded) {
              return Column(
                children: [
                  HomeHeader(lang: lang),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        context.read<HomeBloc>().add(LoadHomeData());
                      },
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            BannerSlider(images: state.banners),
                            CategoryView(state: state, lang: lang),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is HomeError) {
              return Center(child: Text(state.message));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
