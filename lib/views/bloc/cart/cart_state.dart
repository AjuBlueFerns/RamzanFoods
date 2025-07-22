import 'package:crocurry/data/models/cart_details_model.dart';

class CartState {
  CartDetailsModel? cart;
  bool? isLoading;
  final String cartId;
  int? cartCount;
  String subTotal;
  String shippingCharges;
  String discTotal;
  String totalToPay;
  CartState({
    this.cart,
    this.isLoading = true,
    this.cartId = "",
    this.cartCount = 0,
    this.discTotal = "0.00",
    this.shippingCharges = "0.00",
    this.subTotal = "0.00",
    this.totalToPay = "0.00",
  });

  CartState copyWith(
      {CartDetailsModel? cartDetails,
      bool? loading,
      String? id,
      int? count,
      String? sub,
      String? shipping,
      String? disc,
      String? total}) {
    return CartState(
      cart: cartDetails ?? cart,
      isLoading: loading ?? isLoading,
      cartId: id ?? cartId,
      cartCount: count ?? cartCount,
      subTotal: sub ?? subTotal,
      shippingCharges: shipping ?? shippingCharges,
      discTotal: disc ?? discTotal,
      totalToPay: total ?? totalToPay,
    );
  }
}
