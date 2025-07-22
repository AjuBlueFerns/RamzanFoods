//import 'package:objectbox/objectbox.dart';

// @Entity()
class CategoryModel {
  // @Id()
  // int id = 0;
  String? typeId;
  String? productMainCategoryFriendlyName;
  String? mainCategoryId;
  String? productCategoryName;
  String? typeName;
  String? productMainCategoryTitle;
  String? title;
  String? productMainCategoryImage;
  CategoryModel({
    this.mainCategoryId,
    this.productMainCategoryImage,
    this.productCategoryName,
    this.productMainCategoryTitle,
    this.productMainCategoryFriendlyName,
    this.title,
    this.typeId,
    this.typeName,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      typeId: json['type_id'] ?? "",
      mainCategoryId: json['maincategory_id'] ?? "",
      productMainCategoryImage: json['prod_maincat_image'] ?? "",
      title: json['pm18_title'] ?? "",
      productMainCategoryTitle: json['prod_maincat_title'] ?? "",
      typeName: json['type_name'] ?? "",
      productCategoryName: json['prod_maincat_name'] ?? "",
      productMainCategoryFriendlyName: json['prod_maincat_friendly_name'] ?? "",
    );
  }
}
