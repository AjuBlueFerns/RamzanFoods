import 'package:crocurry/data/models/product_model.dart';
import 'package:crocurry/data/repository_impl/product/product_repository_impl.dart';

class CheckIfProductBookmarked {
  final ProductRepositoryImpl repository;
  CheckIfProductBookmarked(this.repository);

  ProductModel? call(String productId, String userName) {
    return repository.checkIfProductBookmarked(productId, userName);
  }
}
