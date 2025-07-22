class BrandModel {
  String? brandId;
  String? brandName;
  String? brandImage;
  String? createdDate;
  String? imgPath;
  String? description;
  BrandModel({
    this.brandId,
    this.brandImage,
    this.brandName,
    this.createdDate,
    this.description,
    this.imgPath,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      brandId: json['brand_id'] ?? "",
      brandImage: json['brand_image'] ?? "",
      brandName: json['brand_name'] ?? "",
      createdDate: json['created_date'] ?? "",
      description: json['description'] ?? "",
      imgPath: json['imgpath'] ?? "",
    );
  }
}
