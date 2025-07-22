abstract class CartEvent {}

class FetchAndUpdateCartdetails extends CartEvent {
  FetchAndUpdateCartdetails();
}

class UpdateCartCount extends CartEvent {
  final int value;
  UpdateCartCount(this.value);
}

class DecrementCount extends CartEvent {}

class UpdateItemQty extends CartEvent {
  String productId;
  String quantity;
  String price;
  UpdateItemQty(this.productId, this.quantity, this.price);
}

class RemoveItem extends CartEvent {
  String productId;
  RemoveItem(this.productId);
}

// class DecrementItemQty extends CartEvent {
//   String productId;
//   String quantity;
//   DecrementItemQty(this.productId, this.quantity);
// }
