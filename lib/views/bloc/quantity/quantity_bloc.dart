import 'package:crocurry/views/bloc/quantity/quantity_event.dart';
import 'package:crocurry/views/bloc/quantity/quantity_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuantityBloc extends Bloc<QuantityEvent, QuantityState> {
  QuantityBloc() : super(QuantityState()) {
    on(incrementQty);
    on(decrementQty);
    on(setPrice);
    on(addingCartStatus);
  }

  Future setPrice(SetUnitPriceAndQty event, Emitter<QuantityState> emit) async {
    emit(state.copyWith(price: event.price, quantity: event.qty, stock: event.stock));
  }

  Future<void> incrementQty(
      IncrementQty event, Emitter<QuantityState> emit) async {
    emit(state.copyWith(quantity: state.qty + 1));
  }

  Future<void> decrementQty(
      DecrementQty event, Emitter<QuantityState> emit) async {
    emit(state.copyWith(quantity: state.qty - 1));
  }

  Future<void> addingCartStatus(
      AddingCartStatus event, Emitter<QuantityState> emit) async {
    emit(state.copyWith(adding: event.status));
  }
}
