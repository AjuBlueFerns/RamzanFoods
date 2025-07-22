import 'dart:convert';

import 'package:crocurry/data/models/cart_details_model.dart';
import 'package:crocurry/data/models/cart_model.dart';
import 'package:crocurry/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// class for performing cart functions using the api
abstract class CartRemoteDatasource {
/// adds the product with product id with specific quantity 
/// and cartId to the cart  
  Future<(CartModel?, Exception?)> addToCart(
    int qty,
    String productId,
    String cartId,
  );

  /// removes the product with product-id and cart-item-number
  /// from the cart with cart-id
  Future removeFromCart(
    String cartId,
    String productId,
    String cartItemNumber,
  );

  /// gets the cart list details
  Future<(CartDetailsModel?, Exception?)> viewCart(String cartId);

  /// updates the quantity of product(product-id, cart-item-number) in cart(cart-id)
  Future updateQtyInCart(
    String cartId,
    String productId,
    String cartItemNumber,
    int newQty,
  );

  /// checks the order status of the cart(cart-id)
  Future<(bool?, Exception?)> checkOrderStatus(String cartId);
}

class CartRemoteDatasourceImpl extends CartRemoteDatasource {
  @override
  Future<(CartModel?, Exception?)> addToCart(
      int qty, String productId, String cartId) async {
    var url = baseUrl + detailsEndPoint;
    var params = {
      "key": 'add-to-cart',
      "qty": qty.toString(),
      "prod_id": productId,
      "api_type": 'json',
    };
    if (cartId.isNotEmpty) {
      params['cart_id_in'] = cartId;
    }

    var uri = Uri.parse(url).replace(queryParameters: params);
    debugPrint("addToCart url : $uri");
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      debugPrint("addToCart resp :${response.body}");
      // return (CartModel.fromJson(jsonDecode(response.body)), null);
      return (CartModel.fromJson(jsonDecode(response.body)), null);
    } else {
      return (null, Exception('Something went wrong'));
    }
  }

  @override
  Future removeFromCart(
      String cartId, String productId, String cartItemNumber) async {
    var url = baseUrl + detailsEndPoint;
    var params = {
      "key": 'remove-from-cart',
      "cart_id_in": cartId,
      "prod_id": productId,
      "cart_item_number": cartItemNumber,
    };

    var uri = Uri.parse(url).replace(queryParameters: params);
    debugPrint("removeFromCart url : $uri");
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      debugPrint("removeFromCart resp :${response.body}");
      // return (CartModel.fromJson(jsonDecode(response.body)), null);
    } else {
      return (null, Exception('Something went wrong'));
    }
  }

  @override
  Future<(CartDetailsModel?, Exception?)> viewCart(String cartId) async {
    var url = baseUrl + mobileAppEndpoint;
    var params = {
      "key": 'get_cart',
      "cart_id": cartId,
    };

    var uri = Uri.parse(url).replace(queryParameters: params);
    debugPrint("viewCart url : $uri");
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      debugPrint("viewCart resp :${response.body}");

      return (CartDetailsModel.fromJson(jsonDecode(response.body)), null);
    } else {
      return (null, Exception('Something went wrong'));
    }
  }

  @override
  Future updateQtyInCart(String cartId, String productId, String cartItemNumber,
      int newQty) async {
    var url = baseUrl + detailsEndPoint;
    var params = {
      "key": 'change-prod-qty',
      "cart_id": cartId,
      "product_id": productId,
      "cart_item_number": cartItemNumber,
      "new_qty": newQty.toString(),
      "api_type": 'json',
    };
    var uri = Uri.parse(url).replace(queryParameters: params);
    debugPrint("updateQtyInCart url : $uri");
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      debugPrint("updateQtyInCart resp :${response.body}");
    } else {
      return (null, Exception('Something went wrong'));
    }
  }

  @override
  Future<(bool?, Exception?)> checkOrderStatus(String cartId) async {
    var url = baseUrl + mobileAppEndpoint;
    var params = {
      "key": 'checkorder',
      "cart_id": cartId,
    };

    var uri = Uri.parse(url).replace(queryParameters: params);
    debugPrint("checkOrderStatus url : $uri");
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      debugPrint("checkOrderStatus resp :${response.body}");
      var jsonBody = jsonDecode(response.body) as Map;
      return (jsonBody['status'] as bool, null);
    } else {
      return (null, Exception('Something went wrong'));
    }
  }
}
