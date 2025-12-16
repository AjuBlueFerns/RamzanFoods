// ignore_for_file: prefer_const_constructors

import 'package:crocurry/data/models/product_details_model.dart';
import 'package:crocurry/data/models/product_model.dart';
import 'package:crocurry/domain/use_cases/product/get_product_details.dart';
import 'package:crocurry/utils/constants.dart';
import 'package:crocurry/utils/extensions/string_extensions.dart';
import 'package:crocurry/utils/locator.dart';
import 'package:crocurry/utils/route/route_constants.dart';
import 'package:crocurry/views/bloc/cart/cart_bloc.dart';
import 'package:crocurry/views/bloc/cart/cart_event.dart';
import 'package:crocurry/views/bloc/quantity/quantity_bloc.dart';
import 'package:crocurry/views/bloc/quantity/quantity_event.dart';
import 'package:crocurry/views/screens/components/cart_button.dart';
import 'package:crocurry/views/screens/home/views/components/cart_icon_widget.dart';
import 'package:crocurry/views/screens/product/views/components/product_info_skeleton.dart';
import 'package:crocurry/views/screens/product/views/components/wishlist_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/product_images.dart';
import 'components/product_info.dart';

/// screen to display the product details
class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({
    super.key,
    this.isProductAvailable = true,
    required this.product,
    // required this.productId,
  });
  final ProductModel product;
  // final String productId;
  final bool isProductAvailable;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  ProductDetailsModel? producDetails;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      updateQuantity(context);
    });
    super.initState();
  }

  Future<void> updateQuantity(BuildContext context) async {
    var result =
        await locator<GetProductDetails>().call(widget.product.productId!);
    producDetails = result.$1;
    if (!context.mounted) return;
    context.read<QuantityBloc>().add(
          SetUnitPriceAndQty(
            qty: widget.product.quantityInCart,
            price: producDetails!.finalPrice!.toDouble(),
            stock: producDetails!.qtyInStock!.toInt(),
          ),
        );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CartButton(
        producDetails: producDetails,
         productModel: widget.product,
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          WishlistIcon(
            product: widget.product,
            producDetails: producDetails,
          ),
          GestureDetector(
            onTap: () async {
              context.read<CartBloc>().add(FetchAndUpdateCartdetails());
              Navigator.pushNamed(context, cartScreenRoute, arguments: true);
            },
            child: CartIconWidget(),
          ),
          SizedBox(width: defaultPadding),
        ],
      ),
      body: SingleChildScrollView(
        child: producDetails == null
            ? Column(
                children: const [
                  ProductImages(
                    images: [],
                    percent: 0.0,
                  ),
                  SizedBox(height: defaultPadding),
                  ProductInfoSkeleton(),
                ],
              )
            : Column(
                children: [
                  ProductImages(
                    images: producDetails!.productImages!,
                    percent: producDetails!.offerDiscPercent!.toDouble(),
                  ),
                  SizedBox(height: defaultPadding),
                  ProductInfo(
                    productModel: widget.product,
                    brand: producDetails!.brandId!.toUpperCase(),
                    title: producDetails!.productName!,
                    isAvailable: widget.isProductAvailable,
                    description: producDetails!.mediaBox!,
                    rating: 0,
                    numOfReviews: 0,
                    price: producDetails!.price!.toDouble(),
                    priceAfterDiscount: producDetails!.finalPrice!.toDouble(),
                  ),
                  SizedBox(height: defaultPadding)
                ],
              ),
      ),
    );
  }
}
