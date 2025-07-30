import 'package:crocurry/utils/common_functions.dart';
import 'package:crocurry/utils/constants.dart';
import 'package:crocurry/utils/extensions/context_extensions.dart';
import 'package:crocurry/utils/extensions/string_extensions.dart';
import 'package:crocurry/utils/helper.dart';
import 'package:crocurry/views/bloc/all_products/all_products_bloc.dart';
import 'package:crocurry/views/bloc/all_products/all_products_event.dart';
import 'package:crocurry/views/bloc/all_products/all_products_state.dart';
import 'package:crocurry/views/bloc/filter/filter_bloc.dart';
import 'package:crocurry/views/screens/components/common_loader.dart';
import 'package:crocurry/views/screens/components/pagination_loader.dart';
import 'package:crocurry/views/screens/home/views/components/products/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductGridview extends StatefulWidget {
  const ProductGridview({
    super.key,
    // required this.scrollController,
  });

  @override
  State<ProductGridview> createState() => _ProductGridviewState();
}

class _ProductGridviewState extends State<ProductGridview> {
  fetchProducts() async {
    var params = context.read<FilterBloc>().state.getParams();
    context.read<AllProductsBloc>().add(FetchAllProductsWithParams(
          params: params,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllProductsBloc, AllProductsState>(
        builder: (context, state) {
      return SizedBox(
        height: context.screenHeight * 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Text(
            //   "Products",
            //   style: Theme.of(context).textTheme.titleSmall,
            // ),

            // if (state.products.isNotEmpty)
            //   const SizedBox(height: defaultPadding),
            state.products.isEmpty
                ? state.isLoading
                    ? Expanded(
                        child: Center(
                          child: CommonLoader(
                            height: context.screenHeight / 2,
                          ),
                        ),
                      )
                    : const SizedBox(
                        height: 200,
                        child: Center(
                          child: Text('No Items'),
                        ),
                      )
                : Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.products.length,
                        // gridDelegate:
                        //     const SliverGridDelegateWithMaxCrossAxisExtent(
                        //   maxCrossAxisExtent: 200.0,
                        //   mainAxisSpacing: defaultPadding,
                        //   crossAxisSpacing: defaultPadding,
                        //   childAspectRatio: 0.66,
                        // ),
                        itemBuilder: (context, index) {
                          var product = state.products[index];
                          if (product.productId == "loading") {
                            return PaginationLoader(
                              callApi: index == state.products.length - 1,
                              apiCall: () {
                                fetchProducts();
                              },
                            );
                          }
                          // var discAmt =
                          //     (product.discountAmount ?? "0").toDouble();
                          // var productPrice = (product.price ?? "0").toDouble();
                          // var discPercent = discAmt == 0.0 && productPrice == 0.0
                          //     ? 0.0
                          //     : (discAmt) / (productPrice) * 100;

                          return ProductCard(
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
                              CommonFunctions.navigateToProductDetails(
                                  context, product);
                            },
                          );
                        }),
                  ),
          ],
        ),
      );
    });
  }
}
