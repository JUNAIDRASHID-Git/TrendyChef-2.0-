import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:trendychef/core/services/api/banner/get.dart';
import 'package:trendychef/core/services/models/banner/banner.dart';

part 'carousel_state.dart';

class BannerSliderCubit extends Cubit<BannerSliderState> {
  Timer? _timer;
  final PageController controller = PageController(viewportFraction: 0.9, initialPage: 1);

  static const Duration autoSlideDuration = Duration(seconds: 4);
  static const Duration animationDuration = Duration(milliseconds: 400);
  static const Duration pauseAfterUserScroll = Duration(seconds: 5);

  BannerSliderCubit()
      : super(BannerSliderState(banners: [], currentPage: 1, isLoading: true));

  Future<void> loadBanners() async {
    try {
      emit(state.copyWith(isLoading: true));
      final banners = await fetchBanner();

      if (banners.isEmpty) {
        emit(BannerSliderState(banners: [], currentPage: 0, isLoading: false));
        return;
      }

      if (banners.length >= 2) {
        final looped = [banners.last, ...banners, banners.first];
        emit(BannerSliderState(banners: looped, currentPage: 1, isLoading: false));
        _startAutoSlide();
      } else {
        emit(BannerSliderState(banners: banners, currentPage: 0, isLoading: false));
      }
    } catch (_) {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _startAutoSlide() {
    _timer?.cancel();
    _timer = Timer.periodic(autoSlideDuration, (_) => _nextPage());
  }

  void _nextPage() {
    if (!controller.hasClients) return;
    final next = controller.page!.round() + 1;
    controller.animateToPage(
      next,
      duration: animationDuration,
      curve: Curves.easeInOut,
    );
  }

  void userScrolled() {
    _timer?.cancel();
    _timer = Timer(pauseAfterUserScroll, _startAutoSlide);
  }

  void updatePage(int index) {
    emit(state.copyWith(currentPage: index));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    controller.dispose();
    return super.close();
  }
}
