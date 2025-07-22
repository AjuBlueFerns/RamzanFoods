import 'package:crocurry/data/models/cart_model.dart';
import 'package:crocurry/data/repository_impl/cart/cart_repository_impl.dart';

class AddToCart {
  final CartRepositoryImpl repository;
  AddToCart(this.repository);

  Future<(CartModel?, Exception?)> call(int qty, String prodId) async {
    return await repository.addToCart(qty, prodId);
  }
}
