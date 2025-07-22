import 'dart:math';

import 'package:crocurry/data/data_sources/cart/cart_local_datasource.dart';
import 'package:crocurry/data/data_sources/cart/cart_remote_datasource.dart';
import 'package:crocurry/data/models/cart_details_model.dart';
import 'package:crocurry/data/models/cart_model.dart';
import 'package:crocurry/domain/repository/cart/repository/cart_repository.dart';
import 'package:flutter/material.dart';

class CartRepositoryImpl extends CartRepository {
  final CartRemoteDatasourceImpl remoteDatasource;
  final CartLocalDatasourceImpl localDatasource;
  CartRepositoryImpl(this.remoteDatasource, this.localDatasource);
  @override
  Future<(CartModel?, Exception?)> addToCart(int qty, String productId) async {
    CartModel? cart;
    Exception? exc;
    try {
      var cartId = await getCartId();
      var result = await remoteDatasource.addToCart(qty, productId, cartId);
      if (result.$1 != null) {
        var cartModel = result.$1;
        if (cartId.isEmpty) {
          await localDatasource.addCartId(cartModel!.cartId!);
        }
        cart = result.$1!;
      }
    } catch (err) {
      exc = Exception(err);
    }
    return (cart, exc);
  }

  @override
  Future removeFromCart(String productId, String cartItemNumber) async {
    var cartId = await getCartId();
    await remoteDatasource.removeFromCart(cartId, productId, cartItemNumber);
  }

  @override
  Future<(CartDetailsModel?, Exception?)> viewCart() async {
    CartDetailsModel? cart;
    Exception? exc;
    try {
      var cartId = await getCartId();
      if (cartId.isNotEmpty) {
        var result = await remoteDatasource.viewCart(cartId);
        debugPrint(" ##### here#");

        if (result.$1 != null) {
          debugPrint(" ##### here");
          cart = result.$1;
        }
      }
    } catch (err) {
      debugPrint(" ##### viewCart err $err#");
      exc = Exception(err);
    }
    return (cart, exc);
  }

  @override
  Future updateQtyInCart(String cartId, String productId, String cartItemNumber,
      int newQty) async {
    try {
      var cartId = await getCartId();
      if (cartId.isNotEmpty) {
        var result = await remoteDatasource.updateQtyInCart(
            cartId, productId, cartItemNumber, newQty);
        if (result.$1 != null) {}
      }
    } catch (err) {
      debugPrint(" error @updateQtyInCart $e");

      // exc = Exception(err);
    }
  }

  @override
  Future<String> getCartId() async {
    var cartId = await localDatasource.getCartId();
    debugPrint("### cartid : $cartId");
    return cartId;
  }

  @override
  Future<(bool?, Exception?)> checkOrderStatus(String cartId) async {
    try {
      if (cartId.isNotEmpty) {
        return await remoteDatasource.checkOrderStatus(cartId);
      } else {
        return (null, null);
      }
    } catch (err) {
      return (null, Exception());
    }
  }

  @override
  Future<void> clearCartId() async {
    return await localDatasource.clearCartId();
  }

  // @override
  // Future<void> addCartItem(CartDetailsItemModel cartItem) async {
  //   // TODO: implement getCartItems
  //   throw UnimplementedError();
  // }

  // @override
  // Future<List<CartDetailsItemModel>> getCartItems() async {
  //   // TODO: implement getCartItems
  //   throw UnimplementedError();
  // }
}
