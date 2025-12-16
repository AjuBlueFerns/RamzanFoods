import 'package:crocurry/domain/use_cases/cart/get_cart_id.dart';
import 'package:crocurry/utils/constants.dart';
import 'package:crocurry/utils/helper.dart';
import 'package:crocurry/utils/locator.dart';
import 'package:crocurry/views/bloc/products/product_bloc.dart';
import 'package:crocurry/views/bloc/products/product_event.dart';
import 'package:crocurry/views/screens/components/loading_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductSkeletonListview extends StatefulWidget {
  const ProductSkeletonListview(
      {super.key,
      this.loadItems = false,
      required this.index,
      this.searchStr,
      this.filterKey});
  final bool loadItems;
  // final Map<String, dynamic>? params;
  final String? searchStr;
  final String? filterKey;
  final int index;
  @override
  State<ProductSkeletonListview> createState() =>
      _ProductSkeletonListviewState();
}

class _ProductSkeletonListviewState extends State<ProductSkeletonListview> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.loadItems) {
        var cartId = await locator<GetCartId>().call();
        debugPrint("loadItems ::: ${widget.loadItems}");
        debugPrint("index ::: ${widget.index}");
        // debugPrint("params ::: ${widget.params}");

        Helper.context!.read<ProductBloc>().add(FetchProducts(
              index: widget.index,
              key: 'pdt-list2',
              pageNumber: '1',
              searchStr: widget.searchStr,
              filterKey: widget.filterKey,
              cartId: cartId,
              // params: {
              //   'key': 'pdt-list2',
              //   'searchStr': "featured",
              // },
            ));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
            6,
            (index) => OutlinedButton(
                  onPressed: null,
                  style: OutlinedButton.styleFrom(
                      minimumSize: const Size(140, 220),
                      maximumSize: const Size(140, 220),
                      padding: const EdgeInsets.all(8)),
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 1.15,
                        child: LoadingShimmer.rectangle(
                          height: 75,
                          width: 75,
                          borderRadius: defaultBorderRadius,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: defaultPadding / 2,
                              vertical: defaultPadding / 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LoadingShimmer.rectangle(
                                height: 10,
                                width: 100,
                              ),
                              const SizedBox(height: defaultPadding / 2),
                              LoadingShimmer.rectangle(
                                height: 10,
                                width: 100,
                              ),
                              const SizedBox(height: defaultPadding / 2),
                              LoadingShimmer.rectangle(
                                height: 10,
                                width: 20,
                              ),
                              const SizedBox(height: defaultPadding / 2),

                              // Text(
                              //   title,
                              //   maxLines: 2,
                              //   overflow: TextOverflow.ellipsis,
                              //   style: Theme.of(context)
                              //       .textTheme
                              //       .titleSmall!
                              //       .copyWith(fontSize: 12),
                              // ),
                              // const Spacer(),
                              LoadingShimmer.rectangle(
                                height: 10,
                                width: 20,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
      ),
    );
    // return ListView.builder(
    //   scrollDirection: Axis.horizontal,
    //   itemCount: 4,
    //   shrinkWrap: true,
    //   itemBuilder: (context, index) => Padding(
    //       padding: EdgeInsets.only(
    //         left: defaultPadding,
    //         right: index == 3 ? defaultPadding : 0,
    //       ),
    //       child: OutlinedButton(
    //         onPressed: null,
    //         style: OutlinedButton.styleFrom(
    //             minimumSize: const Size(140, 220),
    //             maximumSize: const Size(140, 220),
    //             padding: const EdgeInsets.all(8)),
    //         child: Column(
    //           children: [
    //             AspectRatio(
    //               aspectRatio: 1.15,
    //               child: LoadingShimmer.rectangle(
    //                 height: 75,
    //                 width: 75,
    //                 borderRadius: defaultBorderRadius,
    //               ),
    //             ),
    //             Expanded(
    //               child: Padding(
    //                 padding: const EdgeInsets.symmetric(
    //                     horizontal: defaultPadding / 2,
    //                     vertical: defaultPadding / 2),
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [

    //                     LoadingShimmer.rectangle(
    //                       height: 10,
    //                       width: 100,
    //                     ),
    //                     const SizedBox(height: defaultPadding / 2),
    //                     LoadingShimmer.rectangle(
    //                       height: 10,
    //                       width: 100,
    //                     ),
    //                     const SizedBox(height: defaultPadding / 2),
    //                     LoadingShimmer.rectangle(
    //                       height: 10,
    //                       width: 20,
    //                     ),
    //                     const SizedBox(height: defaultPadding / 2),

    //                     // Text(
    //                     //   title,
    //                     //   maxLines: 2,
    //                     //   overflow: TextOverflow.ellipsis,
    //                     //   style: Theme.of(context)
    //                     //       .textTheme
    //                     //       .titleSmall!
    //                     //       .copyWith(fontSize: 12),
    //                     // ),
    //                     // const Spacer(),
    //                     LoadingShimmer.rectangle(
    //                       height: 10,
    //                       width: 20,
    //                     )
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       )),
    // );
  }
}
