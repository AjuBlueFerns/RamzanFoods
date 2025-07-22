import 'package:crocurry/data/models/product_model.dart';

class SearchState {
  final String searchString;
  final bool isLoading;
  final List<ProductModel> searchResults;
  final int pageNumber;
  // final bool isLastPage;
  SearchState({
    this.searchString = "",
    this.isLoading = false,
    this.searchResults = const [],
    this.pageNumber = 1,
    // this.isLastPage= false,
  });

  SearchState copyWith(
      {String? search, bool? loading, List<ProductModel>? items, int? page}) {
    return SearchState(
      searchString: search ?? searchString,
      isLoading: loading ?? isLoading,
      searchResults: items ?? searchResults,
      pageNumber: page ?? pageNumber,
      // isLastPage: isLast?? isLastPage,
    );
  }
}
