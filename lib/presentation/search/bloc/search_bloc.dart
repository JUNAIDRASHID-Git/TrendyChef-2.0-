import 'package:bloc/bloc.dart';
import 'package:trendychef/core/services/api/search/product_search.dart';
import 'package:trendychef/core/services/models/product/product_model.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<Searching>((event, emit) async {
      try {
        emit(SearchLoading());
        await Future.delayed(Duration(seconds: 1));
        List<ProductModel> products = await searchProduct(event.query);

        emit(SearchLoaded(products: products));
      } catch (e) {
        emit(SearchError());
      }
    });
  }
}
