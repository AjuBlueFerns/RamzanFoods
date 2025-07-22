import 'package:crocurry/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants.dart';

class UnitPrice extends StatelessWidget {
  const UnitPrice({
    super.key,
    required this.price,
    this.priceAfterDiscount,
  });

  final double price;
  final double? priceAfterDiscount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Unit Price",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: defaultPadding),
        Text.rich(
          TextSpan(
            text: priceAfterDiscount == 0
                ? "${price.toStringAsFixed(2)}  ".appendRuppeeSymbol
                : "${priceAfterDiscount!.toStringAsFixed(2)}  ".appendRuppeeSymbol,
            style: Theme.of(context).textTheme.titleLarge,
            children: [
              if (priceAfterDiscount != price)
                TextSpan(
                  text: price.toStringAsFixed(2).appendRuppeeSymbol,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).textTheme.bodyMedium!.color,
                        decoration: TextDecoration.lineThrough,
                      ),
                ),
            ],
          ),
        )
      ],
    );
  }
}
