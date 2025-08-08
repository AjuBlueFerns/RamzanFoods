import 'package:crocurry/utils/common_functions.dart';
import 'package:crocurry/utils/extensions/string_extensions.dart';
import 'package:crocurry/views/bloc/products/product_bloc.dart';
import 'package:crocurry/views/bloc/products/product_state.dart';
import 'package:crocurry/views/screens/home/views/components/products/product_card.dart';
import 'package:crocurry/views/screens/home/views/components/products/products_skeleton_listview.dart';
import 'package:crocurry/views/screens/home/views/components/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utils/constants.dart';

class BestSellers extends StatelessWidget {
  const BestSellers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: defaultPadding / 2),
        SectionTitle(
          title: productSectionTitles[2],
        ),
        // Padding(
        //   padding: const EdgeInsets.all(defaultPadding),
        //   child: Text(
        //     "Best sellers",
        //     style: Theme.of(context).textTheme.titleSmall,
        //   ),
        // ),
        // While loading use 👇
        // const ProductsSkelton(),
        BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
          return SizedBox(
            height: 220,
            child: state.loading[2]
                ? const ProductSkeletonListview(
                    index: 2,
                    loadItems: true,
                    // params: {
                    //   'key': 'pdt-list2',
                    //   'filterKey': "featured",
                    // },
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    // Find demoBestSellersProducts on models/ProductModel.dart
                    itemCount: state.products[2].length,
                    itemBuilder: (context, index) {
                      var product = state.products[2][index];
                      return Padding(
                        padding: EdgeInsets.only(
                          left: defaultPadding,
                          right: index == state.products[2].length - 1
                              ? defaultPadding
                              : 0,
                        ),
                        child: ProductCard(
                          productModel: product,
                          image: product.imagePath!,
                          stock: product.qtyInStock!,
                          brandName: product.mainCategory!,
                          title: product.customTitle!,
                          price: product.productMrp!.toDouble(),
                          priceAfterDiscount:
                              product.discountedPrice!.toDouble(),
                          discountpercent:
                              product.offerDiscountPercent!.toDouble(),
                          press: () async {
                            // var response = await locator<ViewCart>().call();
                            // if (context.mounted) {
                            //   var qty = 1;
                            //   var cartItems = response.$1!.items!;
                            //   var itemIndex = cartItems.indexWhere(
                            //       (e) => e.productId! == product.productId!);
                            //   if (itemIndex != -1) {
                            //     cartItems[index].quantity!;
                            //   }
                            //   context.read<QuantityBloc>().add(
                            //       SetUnitPriceAndQty(
                            //           qty: qty,
                            //           price: double.parse(product.price!)));
                            //   Navigator.pushNamed(
                            //       context, productDetailsScreenRoute,
                            //       arguments: product);
                            // }
                            CommonFunctions.navigateToProductDetails(
                                context, product);
                          },
                        ),
                        // child: ProductCard(
                        //   image: demoBestSellersProducts[index].image,
                        //   brandName: demoBestSellersProducts[index].brandName,
                        //   title: demoBestSellersProducts[index].title,
                        //   price: demoBestSellersProducts[index].price,
                        //   priceAfterDiscount:
                        //       demoBestSellersProducts[index].priceAfterDiscount,
                        //   dicountpercent: demoBestSellersProducts[index].dicountpercent,
                        //   press: () {
                        //     Navigator.pushNamed(context, productDetailsScreenRoute,
                        //         arguments: index.isEven);
                        //   },
                        // ),
                      );
                    }),
          );
        })
      ],
    );
  }
}
