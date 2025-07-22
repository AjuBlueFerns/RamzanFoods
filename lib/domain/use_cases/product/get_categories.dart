import 'package:crocurry/data/models/category_model.dart';
import 'package:crocurry/data/repository_impl/product/product_repository_impl.dart';

class GetProductCategories {
  GetProductCategories({
    required this.repository,
  });
  final ProductRepositoryImpl repository;

  Future<(List<CategoryModel>?, Exception?)> call() async {
    return await repository.getCategories();
  }
}
