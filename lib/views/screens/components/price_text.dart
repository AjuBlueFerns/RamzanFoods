import 'package:crocurry/utils/constants.dart';
import 'package:crocurry/utils/extensions/context_extensions.dart';
import 'package:crocurry/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';

class PriceText extends StatelessWidget {
  const PriceText({
    super.key,
    required this.priceAfterDiscount,
    required this.price,
    required this.isColumn,
  });
  final String priceAfterDiscount, price;
  final bool isColumn;

  @override
  Widget build(BuildContext context) {
    return priceAfterDiscount != price
        ? isColumn
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    price.appendRuppeeSymbol,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                      fontSize: 12,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const SizedBox(width: defaultPadding / 4),
                  Text(
                    priceAfterDiscount.appendRuppeeSymbol,
                    style:  TextStyle(
                      color: context.primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  // const SizedBox(width: defaultPadding / 4),
                  // Text(
                  //   "₹$price",
                  //   style: TextStyle(
                  //     color: Theme.of(context).textTheme.bodyMedium!.color,
                  //     fontSize: 10,
                  //     decoration: TextDecoration.lineThrough,
                  //   ),
                  // ),
                ],
              )
            : Row(
                children: [
                  // Text(
                  //   "₹$price",
                  //   style: TextStyle(
                  //     color: Theme.of(context).textTheme.bodyMedium!.color,
                  //     fontSize: 10,
                  //     decoration: TextDecoration.lineThrough,
                  //   ),
                  // ),
                  // const SizedBox(width: defaultPadding / 4),
                  Text(
                    priceAfterDiscount.appendRuppeeSymbol,
                    style:  TextStyle(
                      color: context.primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: defaultPadding / 4),
                  Text(
                    price.appendRuppeeSymbol,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                      fontSize: 12,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              )
        : Row(
            children: [
              Text(
                price.appendRuppeeSymbol,
                style:  TextStyle(
                  color: context.primaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              // Spacer(),
              //  Text(
              //   "$stock",
              //   style: const TextStyle(
              //     color: Color(0xFF31B0D8),
              //     fontWeight: FontWeight.w500,
              //     fontSize: 12,
              //   ),
              // ),
            ],
          );
  }
}
