part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final UserModel user;
  final List<CategoryModel> categories;
  final List<BannerModel> banners;

  HomeLoaded({
    required this.categories,
    required this.banners,
    required this.user,
  });
}

final class HomeError extends HomeState {
  final String message;

  HomeError({required this.message});
}
