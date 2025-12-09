import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:trendychef/core/services/api/category/get.dart';
import 'package:trendychef/core/services/models/category/category.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<CategoryEvent>((event, emit) async {
      emit(CategoryInitial());
      try {
        final categories = await getAllCategoryWithProducts();
        emit(CategoryLoaded(categories: categories));
      } catch (e) {
        emit(CategoryError(error: e.toString()));
      }
    });
  }
}
