import 'package:crocurry/data/models/order_list_item.dart';

class OrdersModel {
  String? orderId;
  String? orderDate;
  String? totalItems;
  String? orderTotalAmount;
  String? paymodeText;
  String? statusText;
  String? deliveryStatusText;
  String? actualOrderStatusText;
  List<OrderListItem>? orderList;
  OrdersModel({
    this.actualOrderStatusText,
    this.deliveryStatusText,
    this.orderDate,
    this.orderId,
    this.orderList,
    this.orderTotalAmount,
    this.paymodeText,
    this.statusText,
    this.totalItems,
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) {
    return OrdersModel(
      actualOrderStatusText: json['actual_order_status_text'] ?? "",
      deliveryStatusText: json['delivery_status_text'] ?? "",
      orderDate: json['order_date'] ?? "",
      orderId: json['order_id'] ?? "",
      orderList: ((json['order-detail'] as Map)['order'] as List).map((e)=> OrderListItem.fromJson(e)).toList(),
      orderTotalAmount: json['order_total_amt'] ?? "",
      paymodeText: json['paymode_text'] ?? "",
      statusText: json['status_text'] ?? "",
      totalItems: json['total_items'] ?? "",
    );
  }
}
