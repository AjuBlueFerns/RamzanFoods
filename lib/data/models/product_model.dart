import 'package:crocurry/utils/common_functions.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class ProductModel {
  @Id()
  int id = 0;
  String? productId;
  String? productName;
  String? customTitle;
  String? friendlyName;
  String? productDesc;
  String? imagePath;
  String? price;
  String? isActive;
  String? isFeatured;
  String? isOffer;
  String? isOfferActive;
  String? hasDiscount;
  String? productMrp;
  String? discountAmount;
  String? discountedPrice;
  String? offerDiscountPercent;
  String? mainCategory;
  String? productSize;
  String? brandId;
  String? qtyInStock;
  String? sortOrder;
  String? activeStatus;
  String? categoryId;
  String? productSubCatId;
  String? ratingCount;
  String? userName;
  // int selectedQuantity;
  String? cartItemNumber;
  int quantityInCart;
  bool isInCart;

  ProductModel({
    this.activeStatus,
    this.brandId,
    this.categoryId,
    this.customTitle,
    this.discountAmount,
    this.friendlyName,
    this.hasDiscount,
    this.imagePath,
    this.isActive,
    this.isFeatured,
    this.isOffer,
    this.isOfferActive,
    this.mainCategory,
    this.price,
    this.productDesc,
    this.productId,
    this.productMrp,
    this.productName,
    this.productSize,
    this.productSubCatId,
    this.qtyInStock,
    this.ratingCount,
    this.sortOrder,
    this.discountedPrice,
    this.offerDiscountPercent,
    this.userName,
    // this.selectedQuantity = 0,
    this.isInCart = false,
    this.cartItemNumber,
    this.quantityInCart = 0,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    // var discountedPrice = "0";
    // var offerPercent = "0";
    // var price = "0";
    // if (json['discounte_price'] != null) {
    //   discountedPrice = json['discounte_price'].toString();
    // } else if (json['discounted_price'] != null) {
    //   discountedPrice = json['discounted_price'].toString();
    // }
    // if (json['offer_discount_percent'] != null) {
    //   offerPercent = json['offer_discount_percent'].toString();
    // }
    // if (json['price'] != null) {
    //   price = json['price'].toString();
    // }

    return ProductModel(
      quantityInCart: json['quantity_in_cart'] ?? 0,
      isInCart: (json['quantity_in_cart'] ?? 0) > 0,
      cartItemNumber: json['cartItemNumber'] ?? "",
      activeStatus: json['active_status'] ?? "",
      brandId: json['brand_id'] ?? "",
      categoryId: json['cat_id'] ?? "",
      customTitle: json['custom_title'] ?? "",
      // discountAmount: json['disc_amt'] ?? "",
      discountAmount: CommonFunctions.floatingValuedString(json['disc_amt'],
          key: 'disc_amt'),
      friendlyName: json['friendly_name'],
      hasDiscount: json['has_discount'] ?? "",
      imagePath: json['image_path'] ?? "",
      isActive: json['is_active'] ?? "",
      isFeatured: json['is_featured'] ?? "",
      isOffer: json['is_offer'] ?? "",
      isOfferActive: json['is_offer_active'] ?? "",
      mainCategory: json['maincat'] ?? "",
      // price: price,
      price: CommonFunctions.floatingValuedString(json['price'], key: 'price'),
      productDesc: json['prod_desc'] ?? "",
      productId: json['prod_id'] ?? "",
      // productMrp: json['prod_mrp'] ?? "",
      productMrp: json['prod_mrp'] ?? "",
      productName: json['prod_name'] ?? "",
      productSize: json['product_size'] ?? "",
      productSubCatId: json['prod_subcat_id'] ?? "",
      qtyInStock: json['quantity_in_stock'] ?? "",
      ratingCount: json['rating_count'] ?? "",
      sortOrder: json['sort_order'] ?? "",
      // discountedPrice: discountedPrice,
      discountedPrice: CommonFunctions.floatingValuedString(
          json['discounte_price'],
          key: 'discounte_price'),
      // offerDiscountPercent: offerPercent,
      offerDiscountPercent: CommonFunctions.floatingValuedString(
          json['offer_discount_percent'],
          key: 'offer_discount_percent'),
    );
  }

  // factory ProductModel.fromLocalModel(ProductLocalModel model) {
  //   return ProductModel(
  //     productId: model.productId,
  //     price: model.price,
  //     qtyInStock: model.qtyInStock,
  //     productName: model.productName,
  //     categoryId: model.categoryId,
  //     customTitle: model.customTitle,
  //     imagePath: model.imagePath,
  //     productDesc: model.productDesc,
  //     brandId: model.brandId,
  //     mainCategory: model.mainCategory,
  //     activeStatus: model.activeStatus,
  //     discountAmount: model.discountAmount,
  //   );
  // }
}
