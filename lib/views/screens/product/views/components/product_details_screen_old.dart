// // ignore_for_file: prefer_const_constructors

// import 'package:crocurry/data/models/product_details_model.dart';
// import 'package:crocurry/data/models/product_model.dart';
// import 'package:crocurry/domain/use_cases/product/check_if_product_bookmarked.dart';
// import 'package:crocurry/domain/use_cases/product/get_product_details.dart';
// import 'package:crocurry/utils/common_dialogs/common_dialogs.dart';
// import 'package:crocurry/utils/common_functions.dart';
// import 'package:crocurry/utils/constants.dart';
// import 'package:crocurry/utils/custom_toast.dart';
// import 'package:crocurry/utils/extensions/context_extensions.dart';
// import 'package:crocurry/utils/extensions/string_extensions.dart';
// import 'package:crocurry/utils/locator.dart';
// import 'package:crocurry/utils/route/route_constants.dart';
// import 'package:crocurry/views/bloc/auth/auth_bloc.dart';
// import 'package:crocurry/views/bloc/bookmark/bookmark_bloc.dart';
// import 'package:crocurry/views/bloc/bookmark/bookmark_event.dart';
// import 'package:crocurry/views/bloc/quantity/quantity_bloc.dart';
// import 'package:crocurry/views/bloc/quantity/quantity_event.dart';
// import 'package:crocurry/views/bloc/quantity/quantity_state.dart';
// import 'package:crocurry/views/bloc/user/user_bloc.dart';
// import 'package:crocurry/views/screens/components/cart_button.dart';
// import 'package:crocurry/views/screens/home/views/components/cart_icon_widget.dart';
// import 'package:crocurry/views/screens/product/views/components/product_info_skeleton.dart';
// import 'package:crocurry/views/screens/product/views/components/product_quantity.dart';
// import 'package:crocurry/views/screens/product/views/components/unit_price.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'components/product_images.dart';
// import 'components/product_info.dart';

// /// screen to display the product details
// class ProductDetailsScreen extends StatefulWidget {
//   const ProductDetailsScreen({
//     super.key,
//     this.isProductAvailable = true,
//     required this.product,
//     // required this.productId,
//   });
//   final ProductModel product;
//   // final String productId;
//   final bool isProductAvailable;

//   @override
//   State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
// }

// class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
//   ProductDetailsModel? producDetails;
//   bool isLoading = true;
//   ProductModel? bookmarkedProduct;
//   bool addToCartClicked = false;
//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       getBookmarkedProduct(context);
//       updateQuantity(context);
//     });
//     super.initState();
//   }

//   getBookmarkedProduct(BuildContext context) {
//     if (context.read<AuthBloc>().state.isLoggedIn) {
//       var userName = context.read<UserBloc>().state.user!.userName!;
//       bookmarkedProduct = locator<CheckIfProductBookmarked>()
//           .call(widget.product.productId!, userName);
//     }

//     isLoading = false;
//     setState(() {});
//     debugPrint("### isbookmarked :${bookmarkedProduct != null}");
//   }

//   updateQuantity(BuildContext context) async {
//     var result =
//         await locator<GetProductDetails>().call(widget.product.productId!);
//     producDetails = result.$1;
//     if (!context.mounted) return;
//     context.read<QuantityBloc>().add(
//           SetUnitPriceAndQty(
//             qty: 1,
//             price: producDetails!.finalPrice!.toDouble(),
//             stock: producDetails!.qtyInStock!.toInt(),
//           ),
//         );
//     setState(() {});
//   }

//   addToCart(int qty) async {
//     var canBeAdded = await CommonFunctions.checkIfItemCanBeAdded(
//       context: context,
//       product: producDetails!,
//       newQty: qty,
//       stockQty: producDetails!.qtyInStock!.toInt(),
//     );
//     if (canBeAdded) {
//       addToCartClicked = true;
//       setState(() {});
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar:
//           BlocBuilder<QuantityBloc, QuantityState>(builder: (context, state) {
//         return CartButton(
//           title: addToCartClicked ? "View Cart >" : " Add to Cart",
//           status: state.addingToCart,
//           price: state.getTotalPrice(),
//           press: () async {
//             /// user is logged to to add to cart
//             if (context.read<AuthBloc>().state.isLoggedIn) {
//               if (!addToCartClicked) {
//                 if (!state.addingToCart) {
//                   addToCart(state.qty);
//                 }
//               } else {
//                 Navigator.pushNamed(context, cartScreenRoute, arguments: true);
//               }
//             } else {
//               await CommonDialogs.showLoginMobileNumberDialog(
//                   context: context,
//                   title: 'Please login to add to cart',
//                   callback: () {
//                     addToCart(state.qty);
//                   });
//             }
//           },
//         );
//       }),
//       body: SafeArea(
//         child: CustomScrollView(
//           slivers: [
//             SliverAppBar(
//               backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//               // floating: true,
//               pinned: true,
//               actions: [
//                 if (!context.read<AuthBloc>().state.isLoggedIn)
//                   IconButton(
//                     onPressed: () {
//                       CustomToast.showInfoMessage(
//                           context: context,
//                           message: 'Login to add to wishlist !');
//                     },
//                     icon: Icon(
//                       Icons.favorite_border_outlined,
//                       color: context.primaryColor,
//                     ),
//                   )
//                 else if (!isLoading)
//                   if (bookmarkedProduct != null)
//                     IconButton(
//                       onPressed: () {
//                         getBookmarkedProduct(context);
//                         context
//                             .read<BookmarkBloc>()
//                             .add(RemoveProductFromBookmark(bookmarkedProduct!));
//                         bookmarkedProduct = null;
//                         setState(() {});
//                         CustomToast.showSuccessMessage(
//                             context: context,
//                             message: 'Removed from wishlist!');
//                       },
//                       icon: Icon(
//                         Icons.favorite_rounded,
//                         color: context.primaryColor,
//                       ),
//                     )
//                   else
//                     IconButton(
//                       onPressed: () {
//                         var product = ProductModel(
//                           productId: producDetails!.productId!,
//                           brandId: producDetails!.brandId,
//                           categoryId: producDetails!.categoryId!,
//                           customTitle: producDetails!.customTitle!,
//                           discountAmount: producDetails!.discAmount!,
//                           imagePath: producDetails!.imagePath!,
//                           isOfferActive: producDetails!.isOfferActive!,
//                           mainCategory: producDetails!.mainCategory!,
//                           price: producDetails!.price!,
//                           productDesc: producDetails!.productDesc!,
//                           productMrp: producDetails!.productMrp!,
//                           productName: producDetails!.productName!,
//                           productSubCatId: producDetails!.productSubCatId!,
//                           qtyInStock: producDetails!.qtyInStock!,
//                           discountedPrice: producDetails!.finalPrice!,
//                           offerDiscountPercent:
//                               producDetails!.offerDiscPercent!,
//                         );
//                         bookmarkedProduct = product;
//                         context
//                             .read<BookmarkBloc>()
//                             .add(AddProductToBookmark(product));
//                         setState(() {});
//                         CustomToast.showSuccessMessage(
//                             context: context, message: 'Added to wishlist!');
//                       },
//                       icon: Icon(
//                         Icons.favorite_border_outlined,
//                         color: context.primaryColor,
//                       ),
//                     ),
//                 CartIconWidget(),
//                 SizedBox(width: defaultPadding),
//               ],
//             ),
//             if (producDetails == null)
//               SliverToBoxAdapter(
//                 child: ProductImages(
//                   images: const [],
//                   percent: 0.0,
//                 ),
//               )
//             else
//               SliverToBoxAdapter(
//                 child: ProductImages(
//                   images: producDetails!.productImages!,
//                   percent: producDetails!.offerDiscPercent!.toDouble(),
//                 ),
//               ),
//             const SliverToBoxAdapter(
//               child: SizedBox(height: defaultPadding),
//             ),

//             // const SliverToBoxAdapter(
//             //   child: SizedBox(height: defaultPadding),
//             // ),
//             if (producDetails != null)
//               ProductInfo(
//                 brand: producDetails!.brandId!.toUpperCase(),
//                 title: producDetails!.productName!,
//                 isAvailable: widget.isProductAvailable,
//                 description: producDetails!.mediaBox!,
//                 rating: 0,
//                 // rating: double.parse(product!.ratingCount!),
//                 numOfReviews: 0,
//                 price: producDetails!.price!.toDouble(),
//                 priceAfterDiscount: producDetails!.finalPrice!.toDouble(),
//               )
//             else
//               ProductInfoSkeleton(),

//             if (!isLoading)
//               SliverToBoxAdapter(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     if (bookmarkedProduct == null)
//                       TextButton(
//                         onPressed: () async {
//                           if (!context.read<AuthBloc>().state.isLoggedIn) {
//                             CustomToast.showInfoMessage(
//                                 context: context,
//                                 message: "Login to add to wishlist !");
//                           } else {
//                             var product = ProductModel(
//                               productId: producDetails!.productId!,
//                               brandId: producDetails!.brandId,
//                               categoryId: producDetails!.categoryId!,
//                               customTitle: producDetails!.customTitle!,
//                               discountAmount: producDetails!.discAmount!,
//                               imagePath: producDetails!.imagePath!,
//                               isOfferActive: producDetails!.isOfferActive!,
//                               mainCategory: producDetails!.mainCategory!,
//                               price: producDetails!.price!,
//                               productDesc: producDetails!.productDesc!,
//                               productMrp: producDetails!.productMrp!,
//                               productName: producDetails!.productName!,
//                               productSubCatId: producDetails!.productSubCatId!,
//                               qtyInStock: producDetails!.qtyInStock!,
//                               discountedPrice: producDetails!.finalPrice!,
//                               offerDiscountPercent:
//                                   producDetails!.offerDiscPercent!,
//                             );
//                             bookmarkedProduct = product;
//                             context
//                                 .read<BookmarkBloc>()
//                                 .add(AddProductToBookmark(product));
//                             setState(() {});
//                             CustomToast.showSuccessMessage(
//                                 context: context,
//                                 message: 'Added to wishlist!');
//                           }
//                         },
//                         child: Text('Add to wishlist'),
//                       )
//                     else
//                       TextButton(
//                         onPressed: () async {
//                           getBookmarkedProduct(context);
//                           context.read<BookmarkBloc>().add(
//                               RemoveProductFromBookmark(bookmarkedProduct!));
//                           bookmarkedProduct = null;
//                           setState(() {});
//                           CustomToast.showSuccessMessage(
//                               context: context,
//                               message: 'Removed from wishlist!');
//                         },
//                         child: Text('Remove from wishlist'),
//                       ),
//                     SizedBox(width: defaultPadding)
//                   ],
//                 ),
//               ),
//             const SliverToBoxAdapter(
//               child: SizedBox(height: defaultPadding),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
