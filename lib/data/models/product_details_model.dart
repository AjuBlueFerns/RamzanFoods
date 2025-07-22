import 'package:crocurry/data/models/product_details_image_model.dart';
import 'package:crocurry/utils/common_functions.dart';

class ProductDetailsModel {
  String? productId;
  String? productName;
  String? productDesc;
  String? imagePath;
  String? price;
  String? isOffer;
  String? isOfferActive;
  String? offerDiscPercent;
  String? mainCategory;
  String? brandId;
  String? qtyInStock;
  String? categoryId;
  String? productSubCatId;
  String? mediaBox;
  String? customTitle;
  String? p18Desc;
  String? discAmount;
  String? finalPrice;
  String? productMrp;
  List<ProductDetailsImageModel>? productImages;

  ProductDetailsModel({
    this.brandId,
    this.categoryId,
    this.customTitle,
    this.imagePath,
    this.isOffer,
    this.isOfferActive,
    this.mainCategory,
    this.mediaBox,
    this.offerDiscPercent,
    this.p18Desc,
    this.price,
    this.productDesc,
    this.productId,
    this.productName,
    this.productMrp,
    this.productSubCatId,
    this.qtyInStock,
    this.discAmount,
    this.finalPrice,
    this.productImages,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      brandId: json['brand_id'] ?? "",
      categoryId: json['cat_id'] ?? "",
      customTitle: json['custom_title'] ?? "",
      imagePath: json['image_path'] ?? "",
      isOffer: json['is_offer'] ?? "",
      isOfferActive: json['is_offer_active'] ?? "",
      mainCategory: json['maincat'] ?? "",
      mediaBox: json['mediabox'] ?? "",
      // offerDiscPercent: json['offer_discount_percent']??"",
      offerDiscPercent: CommonFunctions.floatingValuedString(
          json['offer_discount_percent'],
          key: 'offer_discount_percent'),
      p18Desc: json['p18_desc'] ?? "",
      // price: json['price'] ?? "",
      price: CommonFunctions.floatingValuedString(json['price'], key: 'price'),
      productDesc: json['prod_desc'] ?? "",
      productId: json['prod_id'] ?? "",
      productName: json['prod_name'] ?? "",
      productMrp: CommonFunctions.floatingValuedString(json['prod_mrp'],
          key: 'prod_mrp'),
      productSubCatId: json['prod_subcat_id'] ?? "",
      qtyInStock: json['quantity_in_stock'] ?? "",
      // discAmount: json['disc_amt'] ?? "",
      discAmount: CommonFunctions.floatingValuedString(json['disc_amt'],
          key: 'disc_amt'),
      finalPrice: CommonFunctions.floatingValuedString(json['final_price'],
          key: 'final_price'),
      productImages: ((json['images'] ?? []) as List)
          .map((image) => ProductDetailsImageModel.fromJson(image))
          .toList(),
    );
  }
}
