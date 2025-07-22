import 'package:crocurry/data/models/brand_model.dart';
import 'package:crocurry/data/repository_impl/product/product_repository_impl.dart';

class GetBrands {
  final ProductRepositoryImpl repository;
  GetBrands(this.repository);

  Future<(List<BrandModel>?, Exception?)> call() async {
    return await repository.getProductBrands();
  }
}
