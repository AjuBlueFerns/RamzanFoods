import 'package:crocurry/domain/use_cases/cart/get_cart_id.dart';
import 'package:crocurry/domain/use_cases/cart/view_cart.dart';
import 'package:crocurry/utils/helper.dart';
import 'package:crocurry/utils/locator.dart';
import 'package:crocurry/views/bloc/cart/cart_event.dart';
import 'package:crocurry/views/bloc/cart/cart_state.dart';
import 'package:crocurry/views/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState()) {
    on(fetchCart);
    on(updateCount);
    on(decrementCount);
    on(updateQty);
    on(removeItem);
  }

  Future fetchCart(
      FetchAndUpdateCartdetails event, Emitter<CartState> emit) async {
    var cartId = await locator<GetCartId>().call();
    emit(state.copyWith(
      sub: '0.00',
      shipping: '0.00',
      disc: '0.00',
      total: '0.00',
      loading: true,
      cartDetails: null,
      id: cartId,
      count: cartId.isEmpty ? 0 : state.cartCount,
    ));

    var response = await locator<ViewCart>().call();
    var cartResponse = response.$1;
    if (cartResponse != null) {
      debugPrint("#### subtotalFormatted ${cartResponse.subtotalFormatted}");
    }
    emit(state.copyWith(
      cartDetails: cartResponse,
      shipping: cartResponse?.shippingCharges!,
      sub: cartResponse?.subtotalFormatted!,
      disc: cartResponse?.discountFormatted!,
      total: cartResponse?.totalToPayFormatted!,
      loading: false,
      count: response.$1 == null || response.$1!.items == null
          ? 0
          : response.$1!.items!.length,
    ));
  }

  Future updateCount(UpdateCartCount event, Emitter<CartState> emit) async {
    debugPrint(" ## b4 updating cartcount with value ${event.value}");
    emit(state.copyWith(count: event.value));
  }

  Future decrementCount(DecrementCount event, Emitter<CartState> emit) async {
    emit(state.copyWith(count: state.cartCount! - 1));
  }

  Future updateQty(UpdateItemQty event, Emitter<CartState> emit) async {
    var cart = state.cart;
    if (cart != null) {
      var index =
          cart.items!.indexWhere((item) => item.productId == event.productId);
      if (index > -1) {
        var item = cart.items![index];
        item.quantity = event.quantity;

        var response = await locator<ViewCart>().call();
        if (response.$1 != null) {
          var cartResponse = response.$1;
          debugPrint(
              "#### subtotalFormatted ${cartResponse!.subtotalFormatted}");

          cart.items![index] = item;
          Helper.context?.read<CartProvider>().updateProductQuantity(
              productId: event.productId, qty: event.quantity);
          emit(state.copyWith(
            cartDetails: cart,
            sub: cartResponse.subtotalFormatted!,
            shipping: cartResponse.shippingCharges!,
            disc: cartResponse.discountFormatted!,
            total: cartResponse.totalToPayFormatted!,
          ));
        } else {
          Helper.context?.read<CartProvider>().updateProductQuantity(
              productId: event.productId, qty: event.quantity);
        }
      }
    }
  }

  Future removeItem(RemoveItem event, Emitter<CartState> emit) async {
    // var cart = state.cart;
    if (state.cart != null) {
      if (state.cart!.items != null) {
        state.cart!.items!
            .removeWhere((item) => item.productId == event.productId);
        emit(state.copyWith(cartDetails: state.cart));
      }
    }
  }
}
