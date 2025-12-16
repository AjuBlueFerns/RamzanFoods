import 'package:crocurry/data/models/product_model.dart';
import 'package:crocurry/utils/custom_toast.dart';
import 'package:crocurry/utils/extensions/string_extensions.dart';
import 'package:crocurry/views/bloc/quantity/quantity_bloc.dart';
import 'package:crocurry/views/bloc/quantity/quantity_event.dart';
import 'package:crocurry/views/bloc/quantity/quantity_state.dart';
import 'package:crocurry/views/provider/cart_provider.dart';
import 'package:crocurry/views/screens/product/views/components/product_quantity.dart';
import 'package:crocurry/views/screens/product/views/components/unit_price.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import '../../../../../utils/constants.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo({
    super.key,
    required this.title,
    required this.brand,
    required this.description,
    required this.rating,
    required this.numOfReviews,
    required this.isAvailable,
    required this.price,
    required this.priceAfterDiscount,
    required this.productModel,
  });

  final ProductModel productModel;
  final String title, brand, description;
  final double rating, price, priceAfterDiscount;
  final int numOfReviews;
  final bool isAvailable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            brand.toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: defaultPadding / 2),
          Text(
            title,
            maxLines: 2,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: defaultPadding),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: UnitPrice(
                  price: price.toDouble(),
                  priceAfterDiscount: priceAfterDiscount.toDouble(),
                ),
              ),
              BlocBuilder<QuantityBloc, QuantityState>(
                  // buildWhen: (previous, current) => current is UIUpdateState || current is DecrementQty || current is IncrementQty,
                  builder: (context, state) {
                return ProductQuantity(
                  numOfItem: productModel.quantityInCart,
                  onIncrement: () {
                    if (productModel.quantityInCart ==
                        productModel.qtyInStock!.toInt()) {
                      CustomToast.showErrorMessage(
                          context: context,
                          message:
                              'Only ${productModel.qtyInStock!} item(s) available');
                    } else {
                      if (productModel.qtyInStock!.toInt() >
                          productModel.quantityInCart) {
                        // productModel.quantityInCart++;
                        // context.read<QuantityBloc>().add(UpdateUI());
                        context
                            .read<CartProvider>()
                            .increaseQty(productData: productModel);
                        context.read<QuantityBloc>().add(IncrementQty());
                      }
                    }
                  },
                  onDecrement: () {
                    if (productModel.quantityInCart >= 1) {
                      // context.read<QuantityBloc>().add(UpdateUI());
                      context
                          .read<CartProvider>()
                          .decreaseQty(productData: productModel);
                      context.read<QuantityBloc>().add(DecrementQty());
                    }
                  },
                );
              }),
            ],
          ),
          const SizedBox(height: defaultPadding),
          if (description.trim().isNotEmpty)
            Text(
              "Product info",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
          const SizedBox(height: defaultPadding / 2),
          if (description.trim().isNotEmpty)
            HtmlWidget(
              description,
            ),
          const SizedBox(height: defaultPadding / 2),
        ],
      ),
    );
  }
}
