import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/core/services/api/banner/get.dart';
import 'package:trendychef/core/services/api/cart/get.dart';
import 'package:trendychef/core/services/api/category/get.dart';
import 'package:trendychef/core/services/models/banner/banner.dart';
import 'package:trendychef/core/services/models/cart/cart_item.dart';
import 'package:trendychef/core/services/models/category/category.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<LoadHomeData>((event, emit) async {
      emit(HomeLoading());
      try {
        final banners = await fetchBanner();
        final cartItems = await getCartItems();
        final categories = await getAllCategoryWithProducts();

        emit(
          HomeLoaded(
            categories: categories,
            banners: banners,
            cartItems: cartItems,
          ),
        );
      } catch (e) {
        emit(HomeError(message: e.toString()));
      }
    });
  }
}
