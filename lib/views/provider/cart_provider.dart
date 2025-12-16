import 'package:crocurry/data/models/product_model.dart';
import 'package:crocurry/domain/use_cases/cart/remove_from_cart.dart';
import 'package:crocurry/domain/use_cases/cart/update_qty.dart';
import 'package:crocurry/utils/custom_toast.dart';
import 'package:crocurry/utils/helper.dart';
import 'package:crocurry/utils/locator.dart';
import 'package:crocurry/views/bloc/cart/cart_bloc.dart';
import 'package:crocurry/views/bloc/cart/cart_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartProvider extends ChangeNotifier {
  List<List<ProductModel>> _productModel = [];
  List<List<ProductModel>> get productModel => _productModel;

  void initializeProductData({required List<List<ProductModel>> data}) {
    _productModel = data;
  }

  void addToCart({required ProductModel productData}) {
    productData.isInCart = true;
    productData.quantityInCart++;
    Helper.context!.read<CartBloc>().add(FetchAndUpdateCartdetails());
    notifyListeners();
  }

  Future<void> increaseQty({required ProductModel productData}) async {
    if (productData.quantityInCart < int.tryParse(productData.qtyInStock!)!) {
      try {
        productData.quantityInCart++;
        Helper.showLog(productData.qtyInStock!);
        await locator<UpdateQty>().call(
          productData.productId!,
          productData.cartItemNumber!,
          productData.quantityInCart,
        );
        Helper.context!.read<CartBloc>().add(FetchAndUpdateCartdetails());
        notifyListeners();
      } catch (e) {
        productData.quantityInCart--;
        notifyListeners();
      }
    }
  }

  Future<void> decreaseQty({required ProductModel productData}) async {
    try {
      if (productData.quantityInCart > 1) {
        productData.quantityInCart--;
        var unitPrice = productData.price;

        await locator<UpdateQty>().call(productData.productId!,
            productData.cartItemNumber!, productData.quantityInCart);

        Helper.context!.read<CartBloc>().add(UpdateItemQty(
            productData.productId!,
            productData.quantityInCart.toString(),
            unitPrice!));

        Helper.context!.read<CartBloc>().add(FetchAndUpdateCartdetails());
      } else {
        productData.quantityInCart = 0;
        await locator<RemoveFromCart>()
            .call(productData.productId!, productData.cartItemNumber!);
        Helper.context!
            .read<CartBloc>()
            .add(RemoveItem(productData.productId!));
        Helper.context!.read<CartBloc>().add(FetchAndUpdateCartdetails());
        CustomToast.showInfoMessage(
            context: Helper.context!, message: 'Item deleted!');
        Helper.context!.read<CartBloc>().add(DecrementCount());
      }
      Helper.showLog(productData.qtyInStock!);
      if (productData.quantityInCart == 0) {
        productData.isInCart = false;
      }
      notifyListeners();
    } on Exception catch (e) {
      Helper.showLog("$e exception");
      productData.quantityInCart++;
      notifyListeners();
    }
  }

  void updateProductQuantity({required String productId, required String qty}) {
    for (var e in _productModel.first) {
      if (e.productId == productId) {
        int parsedQty = int.parse(qty);
        e.quantityInCart = parsedQty;
        if (parsedQty == 0) {
          e.isInCart = false;
        }
        Helper.context!.read<CartBloc>().add(FetchAndUpdateCartdetails());
        notifyListeners();
        break;
      }
    }
  }
}
