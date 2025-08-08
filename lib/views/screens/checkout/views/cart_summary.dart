import 'package:crocurry/utils/constants.dart';
import 'package:crocurry/utils/extensions/context_extensions.dart';
import 'package:crocurry/utils/extensions/string_extensions.dart';
import 'package:crocurry/views/bloc/cart/cart_state.dart';
import 'package:flutter/material.dart';

class CartSummary extends StatelessWidget {
  const CartSummary({
    super.key,
    required this.cart,
  });
  final CartState cart;
  @override
  Widget build(BuildContext context) {
    return cart.cartCount == null || cart.cartCount! == 0
        ? const SizedBox.shrink()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    height: 20,
                    width: 6,
                    decoration: BoxDecoration(
                      color: context.primaryColor.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Cart Summary',
                    style: Theme.of(context).textTheme.titleSmall!,
                  ),
                ],
              ),
              const SizedBox(height: defaultPadding),
              Container(
                padding: const EdgeInsets.all(defaultPadding),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: greyColor,
                  ),
                  borderRadius: BorderRadius.circular(defaultBorderRadius),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Text(
                    //   'Cart Summary',
                    //   style: Theme.of(context).textTheme.titleSmall!,
                    // ),
                    // const SizedBox(height: defaultPadding),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('MRP Total'),
                        const Spacer(),
                        Text(cart.subTotal.appendRuppeeSymbol)
                      ],
                    ),
                    const SizedBox(height: defaultPadding),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Delivery Charges'),
                        const Spacer(),
                        if (cart.shippingCharges == "0.00")
                          const Text('Free')
                        else
                          Text(cart.shippingCharges.appendRuppeeSymbol)
                      ],
                    ),
                    const SizedBox(height: defaultPadding),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Discounts',
                          style: TextStyle(
                            color: redColor,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          cart.discTotal.appendRuppeeSymbol,
                          style: const TextStyle(
                            color: redColor,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: defaultPadding),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Grand Total'),
                        const Spacer(),
                        Text(cart.totalToPay.appendRuppeeSymbol)
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: defaultPadding),
            ],
          );
  }
}
