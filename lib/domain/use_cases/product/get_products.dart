import 'package:crocurry/data/models/product_model.dart';
import 'package:crocurry/data/repository_impl/product/product_repository_impl.dart';

class GetProducts {
  GetProducts({
    required this.repository,
  });
  final ProductRepositoryImpl repository;

  Future<(List<ProductModel>?, Exception?)> call(
    Map<String, dynamic>? params,
    String? pageSize,
    String pageNumber,
  ) async {
    return await repository.getProducts(params, pageSize, pageNumber);
  }
}
