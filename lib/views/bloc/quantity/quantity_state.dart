class QuantityState {
  final int qty;
  final int stockQty;
  final double unitPrice;
  final bool addingToCart;
  QuantityState({
    this.qty = 1,
    this.stockQty = 1,
    this.unitPrice = 0,
    this.addingToCart = false,
  });

  QuantityState copyWith(
      {int? quantity, double? price, int? stock, bool? adding}) {
    return QuantityState(
      qty: quantity ?? qty,
      stockQty: stock ?? stockQty,
      unitPrice: price ?? unitPrice,
      addingToCart: adding ?? addingToCart,
    );
  }

  double getTotalPrice() {
    return qty * unitPrice;
  }
}
