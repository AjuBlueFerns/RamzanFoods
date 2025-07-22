import 'package:crocurry/data/repository_impl/cart/cart_repository_impl.dart';

class ClearCartId {
  final CartRepositoryImpl repository;
  ClearCartId(this.repository);

  Future<void> call() async {
    return await repository.clearCartId();
  }
}
