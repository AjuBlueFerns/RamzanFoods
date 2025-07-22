import 'package:crocurry/data/models/product_details_model.dart';
import 'package:crocurry/data/models/product_model.dart';
import 'package:crocurry/domain/use_cases/product/check_if_product_bookmarked.dart';
import 'package:crocurry/utils/custom_toast.dart';
import 'package:crocurry/utils/extensions/context_extensions.dart';
import 'package:crocurry/utils/locator.dart';
import 'package:crocurry/views/bloc/auth/auth_bloc.dart';
import 'package:crocurry/views/bloc/bookmark/bookmark_bloc.dart';
import 'package:crocurry/views/bloc/bookmark/bookmark_event.dart';
import 'package:crocurry/views/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistIcon extends StatefulWidget {
  const WishlistIcon({
    super.key,
    required this.product,
    this.producDetails,
  });
  final ProductModel product;
  final ProductDetailsModel? producDetails;

  @override
  State<WishlistIcon> createState() => _WishlistIconState();
}

class _WishlistIconState extends State<WishlistIcon> {
  ProductModel? bookmarkedProduct;
  bool isLoading = true;

  getBookmarkedProduct(BuildContext context) {
    if (context.read<AuthBloc>().state.isLoggedIn) {
      var userName = context.read<UserBloc>().state.user!.userName!;
      bookmarkedProduct = locator<CheckIfProductBookmarked>()
          .call(widget.product.productId!, userName);
    }

    isLoading = false;
    setState(() {});
    debugPrint("### isbookmarked :${bookmarkedProduct != null}");
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getBookmarkedProduct(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = context.read<AuthBloc>().state.isLoggedIn;
    return IconButton(
      onPressed: () {
        if (!isLoggedIn) {
          CustomToast.showInfoMessage(
              context: context, message: 'Login to add to wishlist !');
        } else {
          if (!isLoading) {
            if (bookmarkedProduct == null) {
              var product = ProductModel(
                productId: widget.producDetails!.productId!,
                brandId: widget.producDetails!.brandId,
                categoryId: widget.producDetails!.categoryId!,
                customTitle: widget.producDetails!.customTitle!,
                discountAmount: widget.producDetails!.discAmount!,
                imagePath: widget.producDetails!.imagePath!,
                isOfferActive: widget.producDetails!.isOfferActive!,
                mainCategory: widget.producDetails!.mainCategory!,
                price: widget.producDetails!.price!,
                productDesc: widget.producDetails!.productDesc!,
                productMrp: widget.producDetails!.productMrp!,
                productName: widget.producDetails!.productName!,
                productSubCatId: widget.producDetails!.productSubCatId!,
                qtyInStock: widget.producDetails!.qtyInStock!,
                discountedPrice: widget.producDetails!.finalPrice!,
                offerDiscountPercent: widget.producDetails!.offerDiscPercent!,
              );
              bookmarkedProduct = product;
              context.read<BookmarkBloc>().add(AddProductToBookmark(product));
              setState(() {});
              CustomToast.showSuccessMessage(
                  context: context, message: 'Added to wishlist!');
            } else if (bookmarkedProduct != null) {
              getBookmarkedProduct(context);
              context
                  .read<BookmarkBloc>()
                  .add(RemoveProductFromBookmark(bookmarkedProduct!));
              bookmarkedProduct = null;
              setState(() {});
              CustomToast.showSuccessMessage(
                  context: context, message: 'Removed from wishlist!');
            }
          }
        }
      },
      icon: Icon(
        !isLoggedIn || bookmarkedProduct == null
            ? Icons.favorite_border_outlined
            : Icons.favorite_rounded,
        color: context.primaryColor,
      ),
    );
  }
}
