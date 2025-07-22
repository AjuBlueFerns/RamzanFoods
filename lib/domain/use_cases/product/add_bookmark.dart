import 'package:crocurry/data/models/product_model.dart';
import 'package:crocurry/data/repository_impl/product/product_repository_impl.dart';

class AddBookmark {
  final ProductRepositoryImpl repository;
  AddBookmark(this.repository);

  Future call(ProductModel product) async {
   await repository.addBookmark(product);
  }
}
