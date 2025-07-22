// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_string_interpolations

import 'package:crocurry/data/models/orders_model.dart';
import 'package:crocurry/data/models/product_model.dart';
import 'package:crocurry/utils/common_functions.dart';
import 'package:crocurry/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:crocurry/utils/constants.dart';
import 'package:crocurry/utils/extensions/string_extensions.dart';
import 'package:crocurry/views/screens/components/network_image_with_loader.dart';

class OrdersListItemView extends StatelessWidget {
  const OrdersListItemView({super.key, required this.order});
  final OrdersModel order;
  @override
  Widget build(BuildContext context) {
    var amount = order.orderTotalAmount!.appendRuppeeSymbol;
    var cartId = "";
    if (order.orderList != null && order.orderList!.isNotEmpty) {
      cartId = order.orderList!.first.cartId ?? "";
    }
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                'Order Id : #${order.orderId}',
                style: Theme.of(context).textTheme.titleSmall!,
              ),
              const Spacer(),
              Text(
                'Status : ${order.statusText}',
                style: Theme.of(context).textTheme.titleSmall!,
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Date : ${order.orderDate}',
                style: Theme.of(context).textTheme.titleSmall!,
              ),
              const Spacer(),
              if (order.statusText == "Processing")
                GestureDetector(
                  onTap: () async {
                    await CommonFunctions.performCheckout(context,
                        retry: true, cartId: cartId);
                  },
                  child: Text(
                    'Retry Payment',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: context.primaryColor,
                        ),
                  ),
                )
            ],
          ),
          const SizedBox(height: defaultPadding),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) {
              return const SizedBox(height: defaultPadding);
            },
            shrinkWrap: true,
            itemCount: order.orderList!.length,
            itemBuilder: (context, index) {
              var item = order.orderList![index];
              var price = item.price!.appendRuppeeSymbol;
              return GestureDetector(
                onTap: () async {
                  CommonFunctions.navigateToProductDetails(
                      context,
                      ProductModel(
                        productId: item.productId!,
                        imagePath: item.prodImage!,
                        customTitle: item.productTitle!,
                        productName: item.productName!,
                      ));
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 75,
                      width: 75,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(defaultBorderRadius),
                      ),
                      child: NetworkImageWithLoader(item.prodImage!),
                    ),
                    const SizedBox(width: defaultPadding),
                    Expanded(
                      child: SizedBox(
                        height: 75,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // const SizedBox(height: defaultPadding / 8),
                            SizedBox(
                              // width: context.screenWidth * 0.6,
                              child: Text(
                                item.productName!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              "Qty : ${item.quantity!}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            // const Spacer(),

                            Text("${price}"),

                            const SizedBox(height: defaultPadding / 4),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
          // const SizedBox(height: defaultPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Total : $amount',
                style: Theme.of(context).textTheme.titleSmall!,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
