import 'package:crocurry/data/repository_impl/cart/cart_repository_impl.dart';

class UpdateQty {
  final CartRepositoryImpl repository;
  UpdateQty(this.repository);

  Future call(
    String cartId,
    String productId,
    String cartItemNumber,
    int newQty,
  ) async {
    return await repository.updateQtyInCart(
        cartId, productId, cartItemNumber, newQty);
  }
}
