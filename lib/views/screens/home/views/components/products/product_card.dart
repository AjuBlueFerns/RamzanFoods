import 'package:crocurry/utils/extensions/string_extensions.dart';
import 'package:crocurry/views/screens/components/offer_banner.dart';
import 'package:crocurry/views/screens/components/price_text.dart';
import 'package:crocurry/views/screens/home/views/components/products/offer_percent_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/constants.dart';
import '../../../../components/network_image_with_loader.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.image,
    required this.brandName,
    required this.title,
    required this.price,
    required this.stock,
    required this.priceAfterDiscount,
    required this.discountpercent,
    required this.press,
  });
  final String image, brandName, title;
  final double price;
  final String stock;
  final double priceAfterDiscount;
  final double discountpercent;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    var percent = discountpercent.toInt();
    return OutlinedButton(
      onPressed: () {
        press.call();
      },
      style: OutlinedButton.styleFrom(
          minimumSize: const Size(140, 220),
          maximumSize: const Size(140, 220),
          padding: const EdgeInsets.only(
            top: defaultPadding / 2,
            left: defaultPadding / 2,
            right: defaultPadding / 2,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AspectRatio(
            aspectRatio: 1.11,
            child: Stack(
              children: [
                if (discountpercent == 0)
                  NetworkImageWithLoader(image, radius: defaultBorderRadius)
                else
                  OfferBanner(
                    padding: 8,
                    child: NetworkImageWithLoader(image,
                        radius: defaultBorderRadius),
                    text: "${discountpercent}% Off".removeDecimal(),
                  ),
                // if (discountpercent != 0)
                //   OfferPercentWidget(
                //     percent: percent.toDouble(),
                //   )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: defaultPadding / 2,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    brandName.toUpperCase().trim(),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 10,
                          // fontWeight: FontWeight.w500,
                          color: blackColor80,
                        ),
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  Text(
                    title.trim(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontSize: 12),
                  ),
                  const Spacer(),
                  PriceText(
                    isColumn: false,
                    priceAfterDiscount: priceAfterDiscount.toString(),
                    price: price.toString(),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
