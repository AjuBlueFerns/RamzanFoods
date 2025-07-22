import 'package:crocurry/data/models/carousal_model.dart';
import 'package:crocurry/data/repository_impl/product/product_repository_impl.dart';

class GetCarousal {
  GetCarousal({
    required this.repository,
  });
  final ProductRepositoryImpl repository;

  Future<(List<CarousalModel>?, Exception?)> call() async {
    return await repository.getCarousalItems();
  }
}
