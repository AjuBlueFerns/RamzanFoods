import 'package:crocurry/data/models/orders_model.dart';

abstract class OrdersRepository {
  Future<(List<OrdersModel>?, Exception?)> getOrdersList();

}