import 'package:crocurry/utils/custom_toast.dart';
import 'package:crocurry/views/bloc/quantity/quantity_bloc.dart';
import 'package:crocurry/views/bloc/quantity/quantity_event.dart';
import 'package:crocurry/views/bloc/quantity/quantity_state.dart';
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
  });

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
                  builder: (context, state) {
                return ProductQuantity(
                  numOfItem: state.qty,
                  onIncrement: () {
                    if (state.qty == state.stockQty) {
                      CustomToast.showErrorMessage(
                          context: context,
                          message:
                              'Only ${state.stockQty} item(s) available');
                    } else {
                      context.read<QuantityBloc>().add(IncrementQty());
                    }
                  },
                  onDecrement: () {
                    if (state.qty > 1) {
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
