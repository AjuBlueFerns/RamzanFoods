import 'package:crocurry/data/models/product_model.dart';

class BookmarkState {
  List<ProductModel> products;
  BookmarkState({
    this.products = const [],
  });

  BookmarkState copyWith({List<ProductModel>? list}) {
    return BookmarkState(
      products: list?? products,
    );
  }
}
