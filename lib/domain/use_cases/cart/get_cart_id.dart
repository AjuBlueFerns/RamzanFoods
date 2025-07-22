import 'package:crocurry/data/repository_impl/cart/cart_repository_impl.dart';

class GetCartId {
  final CartRepositoryImpl repository;
  GetCartId(this.repository);

  Future<String> call() async {
    return await repository.getCartId();
  }
}
