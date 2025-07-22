import 'package:crocurry/data/repository_impl/product/product_repository_impl.dart';

class RemoveBookmark {
  final ProductRepositoryImpl repository;
  RemoveBookmark(this.repository);

  call(int id) {
    repository.removeFromBookmark(id);
  }
}
