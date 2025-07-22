import 'dart:convert';

import 'package:crocurry/data/models/orders_model.dart';
import 'package:crocurry/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class OrderRemoteDataSource {
  /// gets the order-history
  Future<(List<OrdersModel>?, Exception?)> getOrdersList(String userId);
}

class OrderRemoteDataSourceImpl extends OrderRemoteDataSource {
  @override
  Future<(List<OrdersModel>?, Exception?)> getOrdersList(String userId) async {
    var url = baseUrl + mobileAppEndpoint;
    var params = {
      "key": 'get-orders-list',
      "user_id": userId,
    };
    var uri = Uri.parse(url).replace(queryParameters: params);
    debugPrint("getOrdersList url : ${uri.toString()}");

    var response = await http.get(uri);
    // debugPrint("## response :: ${response.body}");
    if (response.statusCode == 200) {
      var respBody = jsonDecode(response.body);
      var orders = (respBody['orders'] as List)
          .map((e) => OrdersModel.fromJson(e))
          .toList();
    debugPrint("## response list length :: ${orders.length}");

      return (orders, null);
    } else {
      return (null, Exception());
    }
  }
}
