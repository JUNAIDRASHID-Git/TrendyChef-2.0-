// bloc/banner_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/core/services/api/banner/get.dart';
import 'banner_event.dart';
import 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  BannerBloc() : super(BannerInitial()) {
    on<LoadBanners>((event, emit) async {
      emit(BannerLoading());
      try {
        final banners = await fetchBanner();
        emit(BannerLoaded(banners));
      } catch (e) {
        emit(BannerError(e.toString()));
      }
    });
  }
}
