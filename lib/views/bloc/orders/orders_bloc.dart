import 'package:crocurry/domain/use_cases/orders/get_orders_list.dart';
import 'package:crocurry/utils/locator.dart';
import 'package:crocurry/views/bloc/orders/orders_event.dart';
import 'package:crocurry/views/bloc/orders/orders_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc() : super(OrdersState()) {
    on(getOrders);
  }

  Future getOrders(FetchOrders event, Emitter<OrdersState> emit) async {
    emit(state.copyWith(loading: true, list: []));
    var response = await locator<GetOrdersList>().call();
    emit(state.copyWith(list: response.$1 ?? [], loading: false));
  }
}
