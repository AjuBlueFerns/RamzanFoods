import 'package:crocurry/data/models/cart_details_model.dart';
import 'package:crocurry/data/repository_impl/cart/cart_repository_impl.dart';

class ViewCart {
  final CartRepositoryImpl repository;
  ViewCart(this.repository);

  Future<(CartDetailsModel?, Exception?)> call() async {
    var cart = await repository.viewCart();
    return cart;
  }
}
