import 'package:crocurry/data/models/orders_model.dart';

class OrdersState {
  List<OrdersModel>? orders;
  bool? isLoading;
  OrdersState({
    this.isLoading = false,
    this.orders = const [],
  });

  OrdersState copyWith({List<OrdersModel>? list, bool? loading}) {
    return OrdersState(
      orders: list ?? orders,
      isLoading: loading ?? isLoading,
    );
  }
}
