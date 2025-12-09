import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:trendychef/core/services/api/category/get.dart';
import 'package:trendychef/core/services/api/product/get.dart';
import 'package:trendychef/core/services/models/category/category.dart';
import 'package:trendychef/core/services/models/product/product_model.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  Future<void> loadProduct({
    required String productId,
    String? categoryId,
  }) async {
    try {
      emit(ProductLoading());

      // Fetch the product
      final product = await getProductByID(productID: productId);

      CategoryModel? category;
      if (categoryId != null && categoryId.isNotEmpty) {
        category = await getCategoryById(categoryId);
      }

      emit(ProductLoaded(product: product, category: category));
    } catch (e) {
      emit(ProductError(error: e.toString()));
    }
  }
}
