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

import 'package:crocurry/data/models/product_model.dart';
import 'package:crocurry/utils/constants.dart';
import 'package:crocurry/utils/custom_toast.dart';
import 'package:crocurry/utils/extensions/string_extensions.dart';
import 'package:crocurry/utils/helper.dart';
import 'package:crocurry/views/bloc/quantity/quantity_bloc.dart';
import 'package:crocurry/views/bloc/quantity/quantity_event.dart';
import 'package:crocurry/views/bloc/quantity/quantity_state.dart';
import 'package:crocurry/views/screens/components/network_image_with_loader.dart';
import 'package:crocurry/views/screens/components/offer_banner.dart';
import 'package:crocurry/views/screens/components/price_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.image,
    required this.productModel,
    required this.brandName,
    required this.title,
    required this.price,
    required this.stock, // Stock might be better as an int or double
    required this.priceAfterDiscount,
    required this.discountpercent,
    required this.press,
  });

  final ProductModel productModel;
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
        TextEditingController(text: productModel.selectedQuantity.toString());

    return Container(
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
          GestureDetector(
            onTap: press,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(defaultBorderRadius),
                  child: SizedBox(
                    // width: Helper.getWidth(context) * 0.25, // Adjust image size
                    // height: Helper.getWidth(context) * 0.25,
                    width: Helper.getWidth(context) / 2.5,
                    height: 120,
                    child: NetworkImageWithLoader(
                      image,
                      radius: defaultBorderRadius,
                      fit: BoxFit.cover,
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
          ),
          Helper.allowWidth(15),
          // Product details section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // Distribute space
              children: [
                GestureDetector(
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: detailsView(context)),
                BlocConsumer<QuantityBloc, QuantityState>(
                  // buildWhen: (previous, current) => current is UIUpdateState,
                  // listenWhen: (previous, current) => current is UIUpdateState,
                  listener: (context, state) {
                    quantityController.text =
                        productModel.selectedQuantity.toString();
                  },
                  builder: (context, state) => Row(
                    children: [
                      SizedBox(
                        width: Helper.getWidth(context) *
                            0.15, // Adjust width for input
                        child: TextFormField(
                          autofocus: false,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              int? newQtty = int.tryParse(value);
                              if (productModel.qtyInStock!.toInt() > newQtty!) {
                                productModel.selectedQuantity =
                                    int.tryParse(value)!;
                              } else {
                                quantityController.text =
                                    productModel.qtyInStock!;
                                productModel.selectedQuantity =
                                    int.tryParse(productModel.qtyInStock!)!;
                                CustomToast.showInfoMessage(
                                    context: context,
                                    message:
                                        "Maximum allowed quantity is ${productModel.qtyInStock!}");
                              }
                              context.read<QuantityBloc>().add(UpdateUI());
                            }
                          },
                          // onTap: () {
                          //   quantityController.selection = TextSelection(
                          //     baseOffset: 0,
                          //     extentOffset: quantityController.text.length,
                          //   );
                          // },
                          onFieldSubmitted: (value) {
                            if (value.isEmpty) {
                              productModel.selectedQuantity = 1;
                              quantityController.text = "1";
                              context.read<QuantityBloc>().add(UpdateUI());
                            }
                          },
                          textAlign: TextAlign.center,
                          controller: quantityController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^[1-9][0-9]*$')),
                          ],
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
                            InkWell(
                              // onTap: () => context
                              //     .read<QuantityBloc>()
                              //     .add(DecrementQty()),
                              onTap: () {
                                if (productModel.selectedQuantity > 1) {
                                  productModel.selectedQuantity--;
                                  context.read<QuantityBloc>().add(UpdateUI());
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Colors.grey[100],
                                ),
                                child: const Icon(Icons.remove, size: 20),
                              ),
                            ),
                            Helper.allowWidth(10),
                            InkWell(
                              onTap: () {
                                if (productModel.qtyInStock!.toInt() >
                                    productModel.selectedQuantity) {
                                  productModel.selectedQuantity++;
                                  context.read<QuantityBloc>().add(UpdateUI());
                                } else {
                                  CustomToast.showInfoMessage(
                                      context: context,
                                      message:
                                          "Maximum allowed quantity is ${productModel.qtyInStock!}");
                                }
                              },

                              // context
                              //     .read<QuantityBloc>()
                              //     .add(IncrementQty()),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Colors.grey[100],
                                ),
                                child: const Icon(Icons.add, size: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget detailsView(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
            style:
                Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 12),
          ),
          Helper.allowHeight(5),
          PriceText(
            isColumn: false,
            priceAfterDiscount: priceAfterDiscount.toString(),
            price: price.toString(),
          ),
          Helper.allowHeight(10),
        ],
      );
}
