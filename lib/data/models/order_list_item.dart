class OrderListItem {
  String? orderId;
  String? productId;
  String? productName;
  String? productTitle;
  String? cartId;
  String? quantity;
  String? price;
  String? totalPrice;
  String? discount;
  String? promoCode;
  String? cartItemNumber;
  String? prodImage;
  OrderListItem({
    this.cartId,
    this.cartItemNumber,
    this.discount,
    this.orderId,
    this.price,
    this.prodImage,
    this.productId,
    this.productName,
    this.productTitle,
    this.promoCode,
    this.quantity,
    this.totalPrice,
  });

  factory OrderListItem.fromJson(Map<String, dynamic> json) {
    return OrderListItem(
      cartId: json['cart_id'] ?? "",
      cartItemNumber: json['cart_item_number'] ?? "",
      discount: json['discount'] ?? "",
      orderId: json['order_id'] ?? "",
      price: json['price'] ?? "",
      prodImage: json['prod_image'] ?? "",
      productId: json['product_id'] ?? "",
      productName: json['product_name'] ?? "",
      productTitle: json['product_title'] ?? "",
      promoCode: json['promo_code'] ?? "",
      quantity: json['quantity'] ?? "",
      totalPrice: json['total_price'] ?? "",
    );
  }
}
