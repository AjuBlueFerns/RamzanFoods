class SubcategoryModel {
  String? prodCategoryId;
  String? productCategoryName;
  String? productCategoryFriendlyName;
  String? productCategoryDesc;
  String? productCategoryImage;
  String? isActive;
  String? sortOrder;
  String? isSingleProduct;
  String? productCategoryTitle;
  String? categoryId;

  SubcategoryModel({
    this.categoryId,
    this.isActive,
    this.isSingleProduct,
    this.prodCategoryId,
    this.productCategoryDesc,
    this.productCategoryFriendlyName,
    this.productCategoryImage,
    this.productCategoryName,
    this.productCategoryTitle,
    this.sortOrder,
  });

  factory SubcategoryModel.fromJson(Map<String, dynamic> json, String categoryId) {
    return SubcategoryModel(
      isActive: json['is_active'] ?? "",
      categoryId: categoryId,
      isSingleProduct: json['is_single_product'] ?? "",
      prodCategoryId: json['prod_cat_id'] ?? "",
      productCategoryDesc: json['prod_cat_desc'] ?? "",
      productCategoryFriendlyName: json['prod_cat_friendly_name'] ?? "",
      productCategoryImage: json['prod_cat_image'] ?? "",
      productCategoryName: json['prod_cat_name'] ?? "",
      productCategoryTitle: json['prod_cat_title'] ?? "",
      sortOrder: json['sort_order'] ?? "",
    );
  }
}
