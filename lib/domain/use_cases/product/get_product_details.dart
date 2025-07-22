import 'package:crocurry/data/models/product_details_model.dart';
import 'package:crocurry/data/repository_impl/product/product_repository_impl.dart';

class GetProductDetails {
  final ProductRepositoryImpl repository;
  GetProductDetails(this.repository);

  Future<(ProductDetailsModel?, Exception?)> call(String productId) async {
    return await repository.getProductdetails(productId);
  }
}
