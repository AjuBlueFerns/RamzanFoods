class ProductDetailsImageModel {
  String? imageId;
  String? imageFileName;
  String? imageFilePath;
  // String? completePath;
  ProductDetailsImageModel({
    this.imageFileName,
    this.imageFilePath,
    this.imageId,
    // this.completePath,
  });

  factory ProductDetailsImageModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsImageModel(
      imageFileName: json['image_file_name'] ?? "",
      imageFilePath: json['image_file_path'] ?? "",
      imageId: json['image_id'] ?? "",
      // completePath: 
    );
  }
}
