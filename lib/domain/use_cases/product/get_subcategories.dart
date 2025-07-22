import 'package:crocurry/data/models/subcategory_model.dart';
import 'package:crocurry/data/repository_impl/product/product_repository_impl.dart';

class GetSubCategories {
  GetSubCategories({
    required this.repository,
  });
  final ProductRepositoryImpl repository;

  Future<(List<SubcategoryModel>?, Exception?)> call(String category) async {
    return await repository.getSubCategories(category);
  }
}
