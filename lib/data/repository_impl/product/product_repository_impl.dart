import 'package:crocurry/data/data_sources/product/product_local_datasource.dart';
import 'package:crocurry/data/data_sources/product/product_remote_datasource.dart';
import 'package:crocurry/data/models/brand_model.dart';
import 'package:crocurry/data/models/carousal_model.dart';
import 'package:crocurry/data/models/category_model.dart';
import 'package:crocurry/data/models/product_details_model.dart';
import 'package:crocurry/data/models/product_model.dart';
import 'package:crocurry/data/models/subcategory_model.dart';
import 'package:crocurry/domain/repository/product/product_repository.dart';
import 'package:flutter/material.dart';

class ProductRepositoryImpl extends ProductRepository {
  ProductRepositoryImpl(this.localDatasource, this.remoteDataSource);
  final ProductRemoteDataSourceImpl remoteDataSource;
  final ProductLocalDatasourceImpl localDatasource;

  @override
  Future<(List<CarousalModel>?, Exception?)> getCarousalItems() async {
    List<CarousalModel>? list;
    Exception? exc;
    try {
      var result = await remoteDataSource.getCarouselItems();
      if (result.$1 != null && result.$1!.isNotEmpty) {
        list = result.$1!;
      }
    } catch (err) {
      exc = Exception(err);
    }
    return (list, exc);
  }

  @override
  Future<(List<CategoryModel>?, Exception?)> getCategories() async {
    List<CategoryModel>? list;
    Exception? exc;
    try {
      var result = await remoteDataSource.getProductCategories();
      if (result.$1 != null && result.$1!.isNotEmpty) {
        list = result.$1!;
      }
    } catch (err) {
      exc = Exception(err);
    }
    return (list, exc);
  }

  @override
  Future<(List<ProductModel>?, Exception?)> getProducts(
    Map<String, dynamic>? params,
    String? pageSize,
    String pageNumber,
  ) async {
    List<ProductModel>? list;
    Exception? exc;
    try {
      var result =
          await remoteDataSource.getProducts(params, pageSize, pageNumber);
      if (result.$1 != null && result.$1!.isNotEmpty) {
        list = result.$1!;
      }
    } catch (err) {
      debugPrint(" errror @get products $err");
      exc = Exception(err);
    }
    return (list, exc);
  }

  @override
  Future<(List<SubcategoryModel>?, Exception?)> getSubCategories(
      String category) async {
    List<SubcategoryModel>? list;
    Exception? exc;
    try {
      var result = await remoteDataSource.getSubcategories(category);
      if (result.$1 != null && result.$1!.isNotEmpty) {
        list = result.$1!;
      }
    } catch (err) {
      exc = Exception(err);
    }
    return (list, exc);
  }

  @override
  Future<(ProductDetailsModel?, Exception?)> getProductdetails(
      String productId) async {
    ProductDetailsModel? product;
    Exception? exc;
    try {
      var result = await remoteDataSource.getProductdetails(productId);
      if (result.$1 != null) {
        product = result.$1!;
      }
    } catch (err) {
      exc = Exception(err);
    }
    return (product, exc);
  }

  @override
  Future addBookmark(ProductModel product) async {
    localDatasource.addBookmark(product);
  }

  @override
  Future<List<ProductModel>> getBookmarks(String userName) async {
    return localDatasource.getBookmarks(userName);
  }

  @override
  removeFromBookmark(int id) {
    return localDatasource.removeFromBookmark(id);
  }

  @override
  ProductModel? checkIfProductBookmarked(String productId, String userName) {
    return localDatasource.checkIfProductBookmarked(productId, userName);
  }

  @override
  Future<(List<BrandModel>?, Exception?)> getProductBrands() async{
     List<BrandModel>? list;
    Exception? exc;
    try {
      var result = await remoteDataSource.getProductBrands();
      if (result.$1 != null && result.$1!.isNotEmpty) {
        list = result.$1!;
      }
    } catch (err) {
      exc = Exception(err);
    }
    return (list, exc);
  }
}
