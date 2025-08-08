// ignore_for_file: prefer_const_constructors

import 'package:crocurry/utils/common_functions.dart';
import 'package:crocurry/utils/constants.dart';
import 'package:crocurry/utils/extensions/context_extensions.dart';
import 'package:crocurry/views/bloc/cart/cart_bloc.dart';
import 'package:crocurry/views/bloc/cart/cart_event.dart';
import 'package:crocurry/views/bloc/cart/cart_state.dart';
import 'package:crocurry/views/bloc/screen/screen_bloc.dart';
import 'package:crocurry/views/bloc/screen/screen_event.dart';
import 'package:crocurry/views/screens/checkout/views/billing_and_shipping_details.dart';
import 'package:crocurry/views/screens/checkout/views/cart_item_skeleteon.dart';
import 'package:crocurry/views/screens/checkout/views/cart_list_items.dart';
import 'package:crocurry/views/screens/checkout/views/cart_summary.dart';
import 'package:crocurry/views/screens/components/common_btn.dart';
import 'package:crocurry/views/screens/home/views/components/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    super.key,
    this.showAppBar = false,
  });
  final bool showAppBar;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<CartBloc>().add(FetchAndUpdateCartdetails());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.showAppBar
          ? AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              centerTitle: true,
              title: const Text('Cart'),
            )
          : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      if (state.cartCount != null &&
                          state.cartCount! > 0 &&
                          state.isLoading!) {
                        return CartItemSkeleteon(
                          count: state.cartCount,
                        );
                      } else {
                        if (state.cartId.isEmpty ||
                            state.cart == null ||
                            state.cart!.items == null ||
                            state.cart!.items!.isEmpty) {
                          return SizedBox(
                            height: context.screenHeight * 0.7,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Spacer(),
                                // SizedBox(height: context.screenHeight * 0.18),

                                Center(
                                  child: Text(
                                    'Your cart is empty!',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                SizedBox(height: defaultPadding),
                                Center(
                                  child: Text(
                                    "There is nothing in your cart. \nLet's add some items!",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                // SizedBox(height: context.screenHeight * 0.2),
                                Spacer(),

                                CommonBtn(
                                  child: Text('Explore Now!'),
                                  onPressed: () {
                                    if (context.isFirst) {
                                      context
                                          .read<ScreenBloc>()
                                          .add(UpdateScreenIndex(index: 1));
                                    } else {
                                      CommonFunctions.navigateToHome(context,
                                          screenIndexToUpdate: 1);
                                    }
                                  },
                                )
                              ],
                            ),
                          );
                        }
                        debugPrint(" ### subtotal ::  ${state.cart!.subTotal}");
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // const SizedBox(height: defaultPadding),
                            const SectionTitle(title: 'Review your order'),
                            CartListItems(cart: state.cart),
                            const SizedBox(height: defaultPadding * 2),
                            // BillingAndShippingDetails(),
                            CartSummary(cart: state),
                            const SizedBox(height: defaultPadding),
                            BillingAndShippingDetails(),
                            // OrderSummary(cart: state),
                            const SizedBox(height: defaultPadding * 2),
                            CommonBtn(
                              onPressed: () async {
                                await CommonFunctions.performCheckout(context);
                              },
                              child: const Text('Checkout'),
                            )
                          ],
                        );
                      }
                    },
                  ),
                  const SizedBox(height: defaultPadding * 2),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
