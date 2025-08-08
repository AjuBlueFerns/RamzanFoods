abstract class QuantityEvent {}

class SetUnitPriceAndQty extends QuantityEvent {
  final double price;
  final int qty;
  final int stock;
  SetUnitPriceAndQty({
    required this.price,
    required this.qty,
    required this.stock,
  });
}

class UpdateUI extends QuantityEvent{}

class IncrementQty extends QuantityEvent {
}

class DecrementQty extends QuantityEvent {}

class AddingCartStatus extends QuantityEvent {
  final bool status;
  AddingCartStatus(this.status);
}
