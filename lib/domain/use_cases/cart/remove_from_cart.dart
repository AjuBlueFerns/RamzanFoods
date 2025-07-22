import 'package:crocurry/data/repository_impl/cart/cart_repository_impl.dart';

class RemoveFromCart {
  final CartRepositoryImpl repository;
  RemoveFromCart(this.repository);

  Future call( String productId, String cartItemNumber) async {
    return await repository.removeFromCart( productId, cartItemNumber);
  }
}
