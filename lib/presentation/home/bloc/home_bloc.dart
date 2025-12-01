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
        final user = await getUser();
        final banners = await fetchBanner();
        final categories = await getAllCategoryWithProducts();

        emit(HomeLoaded(categories: categories, banners: banners, user: user));
      } catch (e) {
        emit(HomeError(message: e.toString()));
      }
    });
  }
}
