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

class MostPopular extends StatelessWidget {
  const MostPopular({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: defaultPadding / 2),
        SectionTitle(
          title: productSectionTitles[3],
        ),
        BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
          return SizedBox(
            height: 220,
            child: state.loading[3]
                ? const ProductSkeletonListview(
                    index: 3,
                    loadItems: true,
                    filterKey: "featured",
                    // params: {
                    //   'key': 'pdt-list2',
                    //   'filterKey': "featured",
                    // },
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.products[3].length,
                    itemBuilder: (context, index) {
                      var product = state.products[3][index];

                      return Padding(
                        padding: EdgeInsets.only(
                          left: defaultPadding,
                          right: index == state.products[3].length - 1
                              ? defaultPadding
                              : 0,
                        ),
                        child: ProductCard(
                          stock: product.qtyInStock!,
                          image: product.imagePath!,
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
                        // child: SecondaryProductCard(
                        //   image: demoPopularProducts[index].image,
                        //   brandName: demoPopularProducts[index].brandName,
                        //   title: demoPopularProducts[index].title,
                        //   price: demoPopularProducts[index].price,
                        //   priceAfterDiscount: demoPopularProducts[index].priceAfterDiscount,
                        //   dicountpercent: demoPopularProducts[index].dicountpercent,
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
