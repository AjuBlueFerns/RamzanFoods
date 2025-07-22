import 'package:crocurry/data/models/cart_model.dart';
import 'package:crocurry/utils/common_functions.dart';
import 'package:crocurry/utils/extensions/string_extensions.dart';

class CartDetailsItemModel {
 
  String? productId;
  String? productName;
  String? customTitle;
  String? cartId;
  String? quantity;
  String? uom;
  String? stepQty;
  String? originalPrice;
  String? price;
  String? discount;
  String? netPrice;
  String? netPriceFormatted;
  String? cartItemNumber;
  String? productImage;

  CartDetailsItemModel({
    this.cartId,
    this.cartItemNumber,
    this.customTitle,
    this.netPrice,
    this.netPriceFormatted,
    this.originalPrice,
    this.price,
    this.discount,
    this.productId,
    this.productImage,
    this.productName,
    this.quantity,
    this.stepQty,
    this.uom,
  });

  factory CartDetailsItemModel.fromJson(Map<String, dynamic> json) {
    return CartDetailsItemModel(
      cartId: json['cartId'] ?? "",
      cartItemNumber: json['cartItemNumber'] ?? "",
      customTitle: json['custom_title'] ?? "",
      // netPrice: json['netPrice'] == null ? "0" : json['newPrice'].toStringA,
      netPrice: CommonFunctions.floatingValuedString(json["netPrice"],
          key: 'netPrice'),
      netPriceFormatted: json['netPriceFormatted'] ?? "",
      // price: json['price'] == null ? "0" : json['price'].toString(),
      price: CommonFunctions.floatingValuedString(json['price'], key: 'price'),
      // discount: json['discount'] == null ? "0" : json['discount'].toString(),
      discount: CommonFunctions.floatingValuedString(json['discount'],
          key: 'discount'),
      productId: json['prodId'] ?? "",
      productImage: json['productImage'] ?? "",
      productName: json['prodName'] ?? "",
      quantity: json['quantity'].toString(),
      stepQty: json['step_qty'] ?? "",
      uom: json['uom'] ?? "",
      // originalPrice: json['original_price'] == null
      //     ? "0"
      //     : json['original_price'].toString(),
      originalPrice: CommonFunctions.floatingValuedString(
          json['original_price'],
          key: 'original_price'),
    );
  }

  factory CartDetailsItemModel.fromCartModel(CartModel cart) {
    return CartDetailsItemModel(
      cartId: cart.cartId,
      cartItemNumber: cart.cartItemNumber,
      productName: cart.cartProductName,
      netPrice: cart.cartTotalPrice,
      productId: cart.productId,
      productImage: cart.cartProductImage,
      quantity: cart.cartUpdatedQuantity,
      price: (cart.cartLineItemTotal!.toDouble() / cart.quantity!.toDouble())
          .toString(),
    );
  }
}
