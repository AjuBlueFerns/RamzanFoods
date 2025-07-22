import 'package:crocurry/data/models/brand_model.dart';
import 'package:crocurry/data/models/carousal_model.dart';
import 'package:crocurry/data/models/category_model.dart';
import 'package:crocurry/data/models/product_details_model.dart';
import 'package:crocurry/data/models/product_model.dart';
import 'package:crocurry/data/models/subcategory_model.dart';

abstract class ProductRepository {
  Future<(List<CarousalModel>?, Exception?)> getCarousalItems();
  Future<(List<CategoryModel>?, Exception?)> getCategories();
  Future<(List<SubcategoryModel>?, Exception?)> getSubCategories(
      String category);
  Future<(List<ProductModel>?, Exception?)> getProducts(
      Map<String, dynamic>? params, String? pageSize, String pageNumber);
  Future<(ProductDetailsModel?, Exception?)> getProductdetails(
      String productId);
  Future addBookmark(ProductModel product);
  removeFromBookmark(int id);
  Future<List<ProductModel>> getBookmarks(String userName);
  ProductModel? checkIfProductBookmarked(String productId, String userName);
    ///  gets the list of product brands
  Future<(List<BrandModel>?, Exception?)> getProductBrands();
}
