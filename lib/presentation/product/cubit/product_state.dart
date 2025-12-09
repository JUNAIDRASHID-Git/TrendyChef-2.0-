part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductLoaded extends ProductState {
  final ProductModel product;
  final CategoryModel? category;

  ProductLoaded({this.category, required this.product});
}

final class ProductError extends ProductState {
  final String error;

  ProductError({required this.error});
}
