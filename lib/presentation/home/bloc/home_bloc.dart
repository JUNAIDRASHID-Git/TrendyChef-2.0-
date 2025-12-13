import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/core/services/api/banner/get.dart';
import 'package:trendychef/core/services/api/category/get.dart';
import 'package:trendychef/core/services/api/user/get.dart';
import 'package:trendychef/core/services/models/banner/banner.dart';
import 'package:trendychef/core/services/models/category/category.dart';
import 'package:trendychef/core/services/models/user/user.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<LoadHomeData>((event, emit) async {
      emit(HomeLoading());
      try {
        final results = await Future.wait([
          getUser(),
          fetchBanner(),
          getAllCategoryWithProducts(),
        ]);

        // Unpack the results in the correct order
        final UserModel user = results[0] as UserModel;
        final List<BannerModel> banners = results[1] as List<BannerModel>;
        final List<CategoryModel> categories = results[2] as List<CategoryModel>;

        emit(HomeLoaded(categories: categories, banners: banners, user: user));
      } catch (e) {
        if (e is Exception) {
          emit(HomeError(message: e.toString()));
        } else {
          emit(HomeError(message: 'An unknown error occurred: $e'));
        }
      }
    });
  }
}
