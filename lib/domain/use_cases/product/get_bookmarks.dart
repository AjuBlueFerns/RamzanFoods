import 'package:crocurry/data/models/product_model.dart';
import 'package:crocurry/data/repository_impl/product/product_repository_impl.dart';

class GetBookmarks {
  final ProductRepositoryImpl repository;
  GetBookmarks(this.repository);

  Future<List<ProductModel>> call(String userName) async{
    return await repository.getBookmarks(userName);
  }
}
