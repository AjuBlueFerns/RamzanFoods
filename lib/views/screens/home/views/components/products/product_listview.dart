import 'package:cached_network_image/cached_network_image.dart';
import 'package:crocurry/data/models/product_model.dart';
import 'package:crocurry/utils/common_dialogs/common_dialogs.dart';
import 'package:crocurry/utils/common_functions.dart';
import 'package:crocurry/utils/extensions/string_extensions.dart';
import 'package:crocurry/utils/helper.dart';
import 'package:crocurry/views/bloc/auth/auth_bloc.dart';
import 'package:crocurry/views/provider/cart_provider.dart';
import 'package:crocurry/views/screens/home/views/components/products/product_card.dart';
import 'package:crocurry/views/screens/home/views/components/products/quantity_stepper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListview extends StatelessWidget {
  const ProductListview({super.key, required this.products});
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      separatorBuilder: (context, index) => Helper.allowHeight(10),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      // scrollDirection: Axis.horizontal,
      // itemCount: min(products.length, 5),
      itemCount: products.length,
      itemBuilder: (context, index) {
        var product = products[index];
        // Helper.showLog(
        //     "Item contains ${DataSources().cartDetailsModel.items!.any((e) => int.tryParse(e.productId!) == product.id).toString()}");
        return Stack(
          clipBehavior: Clip.none,
          children: [
            ProductCard(
              productModel: product,
              stock: product.qtyInStock!,
              image: product.imagePath!,
              brandName: product.mainCategory!,
              title: product.customTitle!,
              price: product.productMrp!.toDouble(),
              priceAfterDiscount: product.discountedPrice!.toDouble(),
              discountpercent: product.offerDiscountPercent!.toDouble(),
              press: () async =>
                  CommonFunctions.navigateToProductDetails(context, product),
            ),

            /// Add Button (Top Right)
            Consumer<CartProvider>(
              builder: (context, value, child) => Positioned(
                bottom: 10,
                right: 10,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () =>
                      _showAddCartView(context: context, productData: product),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: product.isInCart || product.quantityInCart > 0
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.shopping_bag,
                                size: 16,
                                color: Colors.red,
                              ),
                              Helper.allowWidth(2.5),
                              Text(
                                product.quantityInCart.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.red,
                                ),
                              )
                            ],
                          )
                        : const Icon(
                            Icons.add,
                            size: 18,
                            color: Colors.black,
                          ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showAddCartView(
          {required BuildContext context, required ProductModel productData}) =>
      showBottomSheet(
        enableDrag: true,
        showDragHandle: true,
        backgroundColor: Colors.white,
        elevation: 1.0,
        context: context,
        builder: (context) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: SafeArea(
            child: Consumer<CartProvider>(
              builder: (context, value, child) => Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: Helper.getWidth(context) / 3,
                          height: Helper.getHeight(context) / 7,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                    productData.imagePath!),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        Helper.allowWidth(15),
                        Flexible(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(
                                  productData.mainCategory!.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  productData.productName!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  productData.isInCart &&
                                          productData.quantityInCart > 0
                                      ? "₹ ${(double.parse(productData.price!) * productData.quantityInCart).toStringAsFixed(2)}"
                                      : "₹${productData.price!}",
                                ),
                              ),
                              Helper.allowHeight(5),
                              productData.isInCart
                                  ? QuantityStepper(
                                      quantity: productData.quantityInCart,
                                      onAdd: () {
                                        if (context
                                            .read<AuthBloc>()
                                            .state
                                            .isLoggedIn) {
                                          context
                                              .read<CartProvider>()
                                              .increaseQty(
                                                  productData: productData);
                                        } else {
                                          CommonDialogs
                                              .showLoginMobileNumberDialog(
                                            context: context,
                                            title:
                                                'Please login to add to cart',
                                          );
                                        }
                                      },
                                      onRemove: () {
                                        if (context
                                            .read<AuthBloc>()
                                            .state
                                            .isLoggedIn) {
                                          context
                                              .read<CartProvider>()
                                              .decreaseQty(
                                                  productData: productData);
                                        } else {
                                          CommonDialogs
                                              .showLoginMobileNumberDialog(
                                            context: context,
                                            title:
                                                'Please login to add to cart',
                                          );
                                        }
                                      },
                                    )
                                  : SizedBox(
                                      width: double.infinity,
                                      child: TextButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStatePropertyAll(
                                                  Colors.red),
                                        ),
                                        onPressed: () async {
                                          int totalQuantity = int.tryParse(
                                                  productData.qtyInStock!) ??
                                              0;
                                          if (totalQuantity > 0) {
                                            var canBeAdded =
                                                await CommonFunctions
                                                    .checkIfItemCanBeAdded(
                                              context: context,
                                              newQty: 1,
                                              stockQty: totalQuantity,
                                              productId: productData.productId!,
                                              productPrice: productData.price!,
                                              productData: productData,
                                              showSnack: false,
                                            );
                                            if (canBeAdded) {
                                              if (context.mounted) {
                                                context
                                                    .read<CartProvider>()
                                                    .addToCart(
                                                      productData: productData,
                                                    );
                                              }
                                            }
                                          }
                                        },
                                        child: Text(
                                          "ADD",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Helper.allowHeight(30),
                ],
              ),
            ),
          ),
        ),
      );
}
