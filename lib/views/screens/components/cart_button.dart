import 'package:crocurry/data/models/product_details_model.dart';
import 'package:crocurry/data/models/product_model.dart';
import 'package:crocurry/utils/common_dialogs/common_dialogs.dart';
import 'package:crocurry/utils/common_functions.dart';
import 'package:crocurry/utils/extensions/string_extensions.dart';
import 'package:crocurry/utils/helper.dart';
import 'package:crocurry/utils/route/route_constants.dart';
import 'package:crocurry/views/bloc/auth/auth_bloc.dart';
import 'package:crocurry/views/bloc/quantity/quantity_bloc.dart';
import 'package:crocurry/views/bloc/quantity/quantity_state.dart';
import 'package:crocurry/views/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants.dart';

class CartButton extends StatefulWidget {
  const CartButton({
    super.key,
    // required this.price,
    this.subTitle = "Total Price",
    this.producDetails,
    this.productModel,
  });

  // final double price;
  final String subTitle;
  final ProductDetailsModel? producDetails;
  final ProductModel? productModel;

  @override
  State<CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  bool addToCartClicked = false;
  Future<void> addToCart(int qty) async {
    var canBeAdded = await CommonFunctions.checkIfItemCanBeAdded(
      context: context,
      newQty: qty,
      productId: widget.producDetails!.productId!,
      productPrice: widget.producDetails!.price!,
      stockQty: widget.producDetails!.qtyInStock!.toInt(),
    );
    if (canBeAdded) {
      addToCartClicked = true;
      setState(() {});
      Helper.context!
          .read<CartProvider>()
          .addToCart(productData: widget.productModel!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, value, child) =>
          BlocBuilder<QuantityBloc, QuantityState>(builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding,
                vertical: defaultPadding,
              ) +
              const EdgeInsets.only(bottom: 0),
          child: SizedBox(
            height: 64,
            child: Material(
              color: primaryColor,
              clipBehavior: Clip.hardEdge,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(defaultBorderRadius),
                ),
              ),
              child: InkWell(
                onTap: () async {
                  /// user is logged to to add to cart
                  if (context.read<AuthBloc>().state.isLoggedIn) {
                    if (!widget.productModel!.isInCart) {
                      if (!state.addingToCart) {
                        addToCart(state.qty);
                      }
                    } else {
                      Navigator.pushReplacementNamed(context, cartScreenRoute,
                          arguments: true);
                    }
                  } else {
                    await CommonDialogs.showLoginMobileNumberDialog(
                        context: context,
                        title: 'Please login to add to cart',
                        callback: () {
                          addToCart(state.qty);
                        });
                  }
                },
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state
                                  .getTotalPrice()
                                  .toStringAsFixed(2)
                                  .appendRuppeeSymbol,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(color: Colors.white),
                            ),
                            Text(
                              widget.subTitle,
                              style: const TextStyle(
                                  color: Colors.white54,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        alignment: Alignment.center,
                        height: double.infinity,
                        color: Colors.black.withOpacity(0.15),
                        child: state.addingToCart
                            ? const SizedBox(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : Text(
                                widget.productModel!.isInCart
                                    ? "View Cart >"
                                    : " Add to Cart",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(color: Colors.white),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
