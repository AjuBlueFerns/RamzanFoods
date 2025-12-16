import 'package:crocurry/data/models/cart_details_item_model.dart';
import 'package:crocurry/data/models/cart_details_model.dart';
import 'package:crocurry/data/models/product_model.dart';
import 'package:crocurry/domain/use_cases/cart/remove_from_cart.dart';
import 'package:crocurry/domain/use_cases/cart/update_qty.dart';
import 'package:crocurry/utils/common_functions.dart';
import 'package:crocurry/utils/constants.dart';
import 'package:crocurry/utils/custom_toast.dart';
import 'package:crocurry/utils/extensions/string_extensions.dart';
import 'package:crocurry/utils/locator.dart';
import 'package:crocurry/views/bloc/cart/cart_bloc.dart';
import 'package:crocurry/views/bloc/cart/cart_event.dart';
import 'package:crocurry/views/screens/components/network_image_with_loader.dart';
import 'package:crocurry/views/screens/components/price_text.dart';
import 'package:crocurry/views/screens/product/views/components/product_quantity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartListItems extends StatelessWidget {
  const CartListItems({super.key, this.cart});
  final CartDetailsModel? cart;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.only(top: 0),
          child: Divider(
            color: greyColor,
            indent: 0,
            endIndent: 0,
          ),
        );
      },
      shrinkWrap: true,
      itemCount: cart!.items!.length,
      itemBuilder: (context, index) {
        var item = cart!.items![index];
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                CommonFunctions.navigateToProductDetails(
                    context,
                    ProductModel(
                      productId: item.productId!,
                      imagePath: item.productImage!,
                      customTitle: item.customTitle!,
                      productName: item.productName!,
                    ));
              },
              child: Container(
                height: 75,
                width: 75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(defaultBorderRadius),
                ),
                child: NetworkImageWithLoader(item.productImage!),
              ),
            ),
            const SizedBox(width: defaultPadding / 2),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const SizedBox(height: defaultPadding /4),

                  Text(
                    item.productName!.trim(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontSize: 14),
                  ),
                  const SizedBox(height: defaultPadding),
                  Row(
                    children: [
                      SizedBox(
                        width: 75,
                        child: PriceText(
                          isColumn: true,
                          priceAfterDiscount: item.price!,
                          price: item.originalPrice!,
                        ),
                      ),
                      // const Spacer(),
                      ProductQuantity(
                        showTitle: false,
                        numOfItem: int.parse(item.quantity!),
                        onIncrement: () async {
                          var newQty = int.parse(item.quantity!) + 1;
                          await locator<UpdateQty>().call(
                              item.productId!, item.cartItemNumber!, newQty);
                          if (context.mounted) {
                            context.read<CartBloc>().add(UpdateItemQty(
                                item.productId!,
                                newQty.toString(),
                                item.price!));
                          }
                        },
                        onDecrement: () async => await deleteOrDecrement(context, item),
                      ),
                      const Spacer(),
                      PriceText(
                        isColumn: true,
                        priceAfterDiscount:
                            (item.price!.toDouble() * item.quantity!.toInt())
                                .toString(),
                        price: (item.price!.toDouble() * item.quantity!.toInt())
                            .toString(),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future deleteOrDecrement(
      BuildContext context, CartDetailsItemModel item) async {
    var newQty = int.parse(item.quantity!) - 1;
    var unitPrice = item.price;
    if (int.parse(item.quantity!) > 1) {
      await locator<UpdateQty>()
          .call(item.productId!, item.cartItemNumber!, newQty);
      if (context.mounted) {
        context
            .read<CartBloc>()
            .add(UpdateItemQty(item.productId!, newQty.toString(), unitPrice!));
      }
    } else {
      await locator<RemoveFromCart>()
          .call(item.productId!, item.cartItemNumber!);
      if (context.mounted) {
        context.read<CartBloc>().add(RemoveItem(item.productId!));
        context.read<CartBloc>().add(FetchAndUpdateCartdetails());
      }
      if (context.mounted) {
        CustomToast.showInfoMessage(context: context, message: 'Item deleted!');
        context.read<CartBloc>().add(DecrementCount());
      }
    }
  }
}
