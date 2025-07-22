import 'package:crocurry/utils/common_functions.dart';

class CartModel {
  String? productId;
  String? quantity;
  String? cartId;
  String? status;
  String? message;
  bool? cartItemExists;
  String? cartUpdatedQuantity;
  String? cartLineItemTotal;
  String? cartProductAmount;
  int? totalCartQuantity;
  String? cartProductImage;
  String? cartProductName;
  String? cartItemNumber;
  String? cartTotalPrice;
  String? subTotal;
  String? shippingCharges;
  String? subTotalFormatted;
  String? totalToPay;
  String? totalToPayFormatted;

  CartModel({
    this.cartId,
    this.cartItemExists,
    this.cartItemNumber,
    this.cartLineItemTotal,
    this.cartProductAmount,
    this.cartProductImage,
    this.cartProductName,
    this.cartTotalPrice,
    this.cartUpdatedQuantity,
    this.message,
    this.productId,
    this.quantity,
    this.shippingCharges,
    this.status,
    this.subTotal,
    this.subTotalFormatted,
    this.totalCartQuantity,
    this.totalToPay,
    this.totalToPayFormatted,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      cartId: json['cartId'] ?? "",
      cartItemExists: json['cart-item-exists'] ?? "",
      cartItemNumber: json['cart-item-number'] ?? "",
      // cartLineItemTotal: json['cart-lineitem-total'] ?? "",
      cartLineItemTotal:  CommonFunctions.floatingValuedString(json['cart-lineitem-total'], key: 'cart-lineitem-total'),
      // cartProductAmount: json['cart-product-amount'] ?? "",
      cartProductAmount: CommonFunctions.floatingValuedString(json['cart-product-amount'], key: 'cart-product-amount'),
      cartProductImage: json['cart-product-image'] ?? "",
      cartProductName: json['cart-product-name'] ?? "",
      // cartTotalPrice: json['cart-total-price'] ?? "",
      cartTotalPrice: CommonFunctions.floatingValuedString(json['cart-total-price'], key: 'cart-total-price'),
      cartUpdatedQuantity: json['cart-updated-quantity'] ?? "",
      message: json['message'] ?? "",
      productId: json['product-id'] ?? "",
      quantity: json['quantity'] ?? "",
      // shippingCharges: json['shipping_charges'] ?? "",
      shippingCharges: CommonFunctions.floatingValuedString(json['shipping_charges'], key: 'shipping_charges'),
      status: json['status'] ?? "",
      // subTotal: json['subtotal'] ?? 0,
      subTotal: CommonFunctions.floatingValuedString(json['subtotal'], key: 'subtotal'),
      subTotalFormatted: json['subtotal_formatted'] ?? "",
      totalCartQuantity: json['total-cart-qty'] ?? 0,
      // totalToPay: json['total_to_pay'] ?? 0,
      totalToPay: CommonFunctions.floatingValuedString(json['total_to_pay'], key: 'totaltopay'),
      totalToPayFormatted: json['total_to_pay_formatted'] ?? "",
    );
  }
}
