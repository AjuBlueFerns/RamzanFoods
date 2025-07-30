// import 'package:crocurry/utils/constants.dart';
// import 'package:crocurry/utils/extensions/string_extensions.dart';
// import 'package:crocurry/utils/helper.dart';
// import 'package:crocurry/views/screens/components/network_image_with_loader.dart';
// import 'package:crocurry/views/screens/components/offer_banner.dart';
// import 'package:crocurry/views/screens/components/price_text.dart';
// import 'package:flutter/material.dart';

// class ProductCard extends StatelessWidget {
//   const ProductCard({
//     super.key,
//     required this.image,
//     required this.brandName,
//     required this.title,
//     required this.price,
//     required this.stock,
//     required this.priceAfterDiscount,
//     required this.discountpercent,
//     required this.press,
//   });
//   final String image, brandName, title;
//   final double price;
//   final String stock;
//   final double priceAfterDiscount;
//   final double discountpercent;
//   final VoidCallback press;

//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController quantityController =
//         TextEditingController(text: stock);
//     // var percent = discountpercent.toInt();
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
//       child: Expanded(
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadiusGeometry.circular(12.0),
//               child: Image.network(image,
//                   fit: BoxFit.fitWidth,
//                   width: Helper.getWidth(context) / 3,
//                   height: Helper.getWidth(context) / 3),
//             ),
//             Stack(
//               children: [
//                 if (discountpercent == 0)
//                   NetworkImageWithLoader(image, radius: defaultBorderRadius)
//                 else
//                   OfferBanner(
//                     padding: 8,
//                     text: "$discountpercent% Off".removeDecimal(),
//                     child: NetworkImageWithLoader(image,
//                         radius: defaultBorderRadius),
//                   ),
//                 // if (discountpercent != 0)
//                 //   OfferPercentWidget(
//                 //     percent: percent.toDouble(),
//                 //   )
//               ],
//             ),

//             Helper.allowWidth(15),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   brandName.toUpperCase().trim(),
//                   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                         fontSize: 10,
//                         // fontWeight: FontWeight.w500,
//                         color: blackColor80,
//                       ),
//                 ),
//                 const SizedBox(height: defaultPadding / 2),
//                 Text(
//                   title.trim(),
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: Theme.of(context)
//                       .textTheme
//                       .titleSmall!
//                       .copyWith(fontSize: 12),
//                 ),
//                 Helper.allowHeight(5),
//                 // PriceText(
//                 //   isColumn: false,
//                 //   priceAfterDiscount: priceAfterDiscount.toString(),
//                 //   price: price.toString(),
//                 // ),

//                 Helper.allowHeight(10),
//                 Expanded(
//                   child: Row(
//                     children: [
//                       SizedBox(
//                         width: Helper.getWidth(context) / 4,
//                         child: TextFormField(
//                           textAlign: TextAlign.center,
//                           controller: quantityController,
//                         ),
//                       ),
//                       Helper.allowWidth(10),
//                       Expanded(
//                         child: Row(
//                           mainAxisSize: MainAxisSize.max,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 12, vertical: 8),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(8.0),
//                                 color: Colors.grey[100],
//                               ),
//                               child: const Center(child: Icon(Icons.add)),
//                             ),
//                             Helper.allowWidth(10),
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 12, vertical: 8),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(8.0),
//                                 color: Colors.grey[100],
//                               ),
//                               child: const Center(child: Icon(Icons.remove)),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:crocurry/utils/constants.dart';
import 'package:crocurry/utils/extensions/string_extensions.dart';
import 'package:crocurry/utils/helper.dart';
import 'package:crocurry/views/screens/components/network_image_with_loader.dart';
import 'package:crocurry/views/screens/components/offer_banner.dart';
import 'package:crocurry/views/screens/components/price_text.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.image,
    required this.brandName,
    required this.title,
    required this.price,
    required this.stock, // Stock might be better as an int or double
    required this.priceAfterDiscount,
    required this.discountpercent,
    required this.press,
  });

  final String image, brandName, title;
  final double price;
  final String stock; // Consider changing this to int or double
  final double priceAfterDiscount;
  final double discountpercent;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    // Initialize with a default quantity, not necessarily the entire stock
    final TextEditingController quantityController =
        TextEditingController(text: '1');

    return GestureDetector(
      onTap: press, // Make the entire card tappable
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white, // Add a background color for better visibility
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(defaultBorderRadius),
                  child: SizedBox(
                    width: Helper.getWidth(context) * 0.25, // Adjust image size
                    height: Helper.getWidth(context) * 0.25,
                    child: NetworkImageWithLoader(
                      image,
                      radius: defaultBorderRadius,
                    ),
                  ),
                ),
                if (discountpercent != 0)
                  Positioned(
                    top: 0,
                    left: 0,
                    child: OfferBanner(
                      padding: 8,
                      text: "$discountpercent% Off".removeDecimal(),
                      child: const SizedBox
                          .shrink(), // OfferBanner already has the design, no need for child here if it's just a text overlay
                    ),
                  ),
              ],
            ),
            Helper.allowWidth(15),
            // Product details section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // Distribute space
                children: [
                  Text(
                    brandName.toUpperCase().trim(),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 10,
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
                  Helper.allowHeight(5),
                  PriceText(
                    isColumn: false,
                    priceAfterDiscount: priceAfterDiscount.toString(),
                    price: price.toString(),
                  ),
                  Helper.allowHeight(10),
                  Row(
                    children: [
                      SizedBox(
                        width: Helper.getWidth(context) *
                            0.15, // Adjust width for input
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: quantityController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                          ),
                        ),
                      ),
                      Helper.allowWidth(10),
                      // Add and Remove buttons
                      Expanded(
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.end, // Align buttons to the end
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.grey[100],
                              ),
                              child: const Icon(Icons.remove, size: 20),
                            ),
                            Helper.allowWidth(10),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.grey[100],
                              ),
                              child: const Icon(Icons.add, size: 20),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
