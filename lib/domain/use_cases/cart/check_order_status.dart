import 'package:crocurry/data/repository_impl/cart/cart_repository_impl.dart';
import 'package:flutter/material.dart';

class CheckOrderStatus {
  final CartRepositoryImpl repository;
  CheckOrderStatus(this.repository);

  Future<(bool?, Exception?)> call(String cartId) async {
    debugPrint("### CheckOrderStatus call");
    return await repository.checkOrderStatus(cartId);
  }
}
