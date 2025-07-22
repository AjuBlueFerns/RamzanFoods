import 'package:crocurry/utils/common_functions.dart';
import 'package:crocurry/utils/constants.dart';
import 'package:crocurry/utils/extensions/context_extensions.dart';
import 'package:crocurry/utils/extensions/string_extensions.dart';
import 'package:crocurry/views/bloc/bookmark/bookmark_bloc.dart';
import 'package:crocurry/views/bloc/bookmark/bookmark_state.dart';
import 'package:crocurry/views/screens/home/views/components/products/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});
// final List<>
  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Wishlist'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(defaultPadding),
            //   child: Text(
            //     "Your Wish-lists",
            //     style: Theme.of(context).textTheme.titleSmall,
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: BlocBuilder<BookmarkBloc, BookmarkState>(
                builder: (context, state) {
                  return state.products.isEmpty
                      ? SizedBox(
                          height: context.screenHeight * 0.3,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Spacer(),
                              Center(child: Text('No items !')),
                            ],
                          ),
                        )
                      : GridView.builder(
                          reverse: false,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.products.length,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200.0,
                            mainAxisSpacing: defaultPadding,
                            crossAxisSpacing: defaultPadding,
                            childAspectRatio: 0.66,
                          ),
                          itemBuilder: (context, index) {
                            var product = state.products[index];
                            // var localProduct =
                            //     ProductModel.fromLocalModel(product);
                            debugPrint(
                                " ## productName : ${product.productName}");
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
                          });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void fetchProducts({String? page}) async {
  //   context
  //       .read<SearchBloc>()
  //       .add(PerformSearch(text: textToSearch, page: page));
  //   if (scrollController.hasClients) {
  //     // await Future.delayed(Duration(seconds: 1));
  //     //  scrollController.jumpTo(
  //     //   scrollController.position.maxScrollExtent + 200,
  //     //   // duration: const Duration(seconds: 1),
  //     //   // curve: Curves.easeIn,
  //     // );
  //     setState(() {});
  //   }
  // }
}
