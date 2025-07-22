import 'package:crocurry/data/models/category_model.dart';
import 'package:crocurry/data/models/product_model.dart';
import 'package:crocurry/objectbox.g.dart';
import 'package:crocurry/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProductLocalDatasource {
  /// adds a product to the objectbox store
  Future addBookmark(ProductModel product);

  /// removes product with id from objectbox store
  removeFromBookmark(int id);

  /// list all the bookmarked items of the userc
  List<ProductModel> getBookmarks(String userName);

  /// returns the bookmarked item details of the product
  ProductModel? checkIfProductBookmarked(String productId, String userName);

  ///  gets the list of product categories
  Future<List<CategoryModel>> getProductCategoriesFromLocal();

  ///  gets the list of product categories
  addProductCategoriesToLocal(List<CategoryModel> categories);
}

class ProductLocalDatasourceImpl extends ProductLocalDatasource {
  final Store store;
  ProductLocalDatasourceImpl(this.store);
  @override
  Future addBookmark(ProductModel product) async {
    final prefs = await SharedPreferences.getInstance();
    var userName = prefs.getString(userNameKey);
    product.userName = userName;
    var productExists =
        checkIfProductBookmarked(product.productId!, userName!) != null;
    if (!productExists) {
      store.box<ProductModel>().put(product);
    }
  }

  @override
  removeFromBookmark(int id) {
    store.box<ProductModel>().remove(id);
  }

  @override
  List<ProductModel> getBookmarks(String userName) {
    var list = store.box<ProductModel>().getAll();
    var filteredList =
        list.where((product) => product.userName == userName).toList();

    return filteredList;
  }

  @override
  ProductModel? checkIfProductBookmarked(String productId, String userName) {
    var list = getBookmarks(userName);
    ProductModel? productFromDb;
    for (var i in list) {
      if (i.productId == productId) {
        productFromDb = i;
      }
    }
    return productFromDb;
  }

  @override
  Future<List<CategoryModel>> getProductCategoriesFromLocal() async {
    var list = store.box<CategoryModel>().getAll();

    return list;
  }

  @override
  addProductCategoriesToLocal(List<CategoryModel> categories) {
    for (var i in categories) {
      store.box<CategoryModel>().put(i);
    }
  }
}
