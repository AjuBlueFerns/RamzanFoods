import 'package:crocurry/data/models/orders_model.dart';
import 'package:crocurry/data/repository_impl/orders/orders_repository_impl.dart';

class GetOrdersList {
  final OrdersRepositoryImpl repository;
  GetOrdersList(this.repository);

  Future<(List<OrdersModel>?, Exception?)> call() async {
    return await repository.getOrdersList();
  }
}
