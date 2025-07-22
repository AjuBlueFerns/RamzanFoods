import 'package:crocurry/data/models/cart_details_item_model.dart';
import 'package:crocurry/utils/common_functions.dart';

class CartDetailsModel {
  List<CartDetailsItemModel>? items;
  String? subTotal;
  String? shippingCharges;
  String? subtotalFormatted;
  String? discountTotal;
  String? discountFormatted;
  String? totalToPay;
  String? totalToPayFormatted;
  CartDetailsModel({
    this.items,
    this.shippingCharges,
    this.subTotal,
    this.subtotalFormatted,
    this.discountTotal,
    this.discountFormatted,
    this.totalToPay,
    this.totalToPayFormatted,
  });

  factory CartDetailsModel.fromJson(Map<String, dynamic> json) {
    return CartDetailsModel(
      items: (json['items'] as List)
          .map((e) => CartDetailsItemModel.fromJson(e))
          .toList(),
      // shippingCharges: json['shipping_charges'] == null
      //     ? "0.0"
      //     : json['shipping_charges'].toString(),
      shippingCharges: CommonFunctions.floatingValuedString(
          json['shipping_charges'],
          key: 'shipping_charges'),
      subTotal: CommonFunctions.floatingValuedString(json['subtotal'],
          key: 'subtotal'),
      subtotalFormatted: json['subtotal_formatted'] == null
          ? "0.0"
          : json['subtotal_formatted'].toString(),
      // totalToPay: json['total_to_pay'] == null
      //     ? "0.0"
      //     : json['total_to_pay'].toString(),
      totalToPay: CommonFunctions.floatingValuedString(json['total_to_pay'],
          key: 'total_to_pay'),
      // discountTotal: json['discount_total'] == null
      //     ? "0.0"
      //     : json['discount_total'].toString(),
      discountTotal: CommonFunctions.floatingValuedString(
          json['discount_total'],
          key: 'discount_total'),
      totalToPayFormatted: json['total_to_pay_formatted'] == null
          ? "0.0"
          : json['total_to_pay_formatted'].toString(),
      discountFormatted: json['discount_formatted'] == null
          ? "0.0"
          : json['discount_formatted'].toString(),
    );
  }
}
