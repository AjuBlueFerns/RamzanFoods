import 'package:crocurry/data/models/product_model.dart';

class ProductState {
  final List<bool> loading;
  final List<List<ProductModel>> products;
  // ProductState({this.loading = const [], this.products = const []});

  ProductState({List<bool>? loading, List<List<ProductModel>>? products})
      : loading = loading ??
            List.filled(10, true), // Initialize loading with 10 true values
        products = products ??
            List.generate(
                10, (_) => []); // Initialize products with 10 empty sublists

  ProductState copyWith(
      {List<bool>? isLoading,
      List<List<ProductModel>>? productList,
      int? index}) {
    return ProductState(
      loading: isLoading ?? loading,
      products: productList ?? products,
    );
  }
}
