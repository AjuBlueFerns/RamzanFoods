import 'package:crocurry/data/models/product_model.dart';

class AllProductsState {
  final bool isLoading;
  final List<ProductModel> products;
  final int pageNumber;
  final String categoryId;
  final String subCategoryId;
  AllProductsState({
    this.isLoading = false,
    this.pageNumber=1,
    this.products = const [],
    this.categoryId="",
    this.subCategoryId="",
  });

  AllProductsState copyWith({bool? loading, List<ProductModel>? productList, int? page, String? catId,String? subCatId }) {
    return AllProductsState(
      isLoading: loading ?? isLoading,
      products: productList ?? products,
      pageNumber: page?? pageNumber,
      subCategoryId: subCatId?? subCategoryId,
      categoryId: catId?? categoryId,
    );
  }
}
