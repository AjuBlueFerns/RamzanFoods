import 'dart:convert';

import 'package:crocurry/data/models/brand_model.dart';
import 'package:crocurry/data/models/carousal_model.dart';
import 'package:crocurry/data/models/category_model.dart';
import 'package:crocurry/data/models/product_details_model.dart';
import 'package:crocurry/data/models/product_model.dart';
import 'package:crocurry/data/models/subcategory_model.dart';
import 'package:crocurry/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class ProductRemoteDatasource {
  /// gets the list of carousal items
  Future<(List<CarousalModel>?, Exception?)> getCarouselItems();

  ///  gets the list of product categories
  Future<(List<CategoryModel>?, Exception?)> getProductCategories();

  /// gets the list of product with specified params and pagination details
  Future<(List<ProductModel>?, Exception?)> getProducts(
      Map<String, dynamic>? params, String? pageSize, String pageNumber);

  /// get sproduct subcategories fro a category
  Future<(List<SubcategoryModel>?, Exception?)> getSubcategories(
      String category);

  /// gets the product details
  Future<(ProductDetailsModel?, Exception?)> getProductdetails(
      String productId);

  ///  gets the list of product brands
  Future<(List<BrandModel>?, Exception?)> getProductBrands();
}

class ProductRemoteDataSourceImpl extends ProductRemoteDatasource {
  ProductRemoteDataSourceImpl();
  @override
  Future<(List<CarousalModel>?, Exception?)> getCarouselItems() async {
    var url = baseUrl + detailsEndPoint;
    debugPrint(" url :$url");
    var params = {
      "key": 'get-articles',
      'cid': "532",
    };
    var response =
        await http.get(Uri.parse(url).replace(queryParameters: params));
    if (response.statusCode == 200) {
      final List respBody = jsonDecode(response.body);
      var list = respBody.map((e) => CarousalModel.fromJson(e)).toList();
      return (list, null);
    } else {
      return (null, Exception(''));
    }
  }

  @override
  Future<(List<CategoryModel>?, Exception?)> getProductCategories() async {
    var url = baseUrl + mobileAppEndpoint;
    var params = {
      "key": 'main-cat-mzi-style',
    };
    var uri = Uri.parse(url).replace(queryParameters: params);
    debugPrint("getProductCategories url : $uri");
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      final List respBody = jsonDecode(response.body)['maincats'];
      var list = respBody.map((e) => CategoryModel.fromJson(e)).toList();
      return (list, null);
    } else {
      return (null, Exception(''));
    }
  }

  @override
  Future<(List<ProductModel>?, Exception?)> getProducts(
      Map<String, dynamic>? params, String? pageSize, String pageNumber) async {
    var url = baseUrl + mobileAppEndpoint;
    debugPrint("getProducts params :${params.toString()}");
    Map<String, dynamic> newMap =
        params != null ? Map<String, dynamic>.from(params) : {};
    newMap['paging_size'] = pageSize ?? "10";
    newMap['paging_no'] = pageNumber;

    debugPrint("getProducts params :${newMap.toString()}");

    var uri = Uri.parse(url).replace(queryParameters: newMap);
    debugPrint("getProducts url : ${uri.toString()}");

    var response = await http.get(uri);
    if (response.statusCode == 200) {
      final List respBody = jsonDecode(response.body)['listing'];
      var list = respBody.map((e) => ProductModel.fromJson(e)).toList();
      return (list, null);
    } else {
      return (null, Exception(''));
    }
  }

  @override
  Future<(List<SubcategoryModel>?, Exception?)> getSubcategories(
      String category) async {
    var url = baseUrl + mobileAppEndpoint;
    var params = {
      "key": 'cat_by_main',
      "mainCatId": category,
    };
    var uri = Uri.parse(url).replace(queryParameters: params);
    debugPrint("getSubcategories url : ${uri.toString()}");

    var response = await http.get(uri);
    if (response.statusCode == 200) {
      final List respBody = jsonDecode(response.body);
      var list =
          respBody.map((e) => SubcategoryModel.fromJson(e, category)).toList();
      return (list, null);
    } else {
      return (null, Exception(''));
    }
  }

  @override
  Future<(ProductDetailsModel?, Exception?)> getProductdetails(
      String productId) async {
    var url = baseUrl + mobileAppEndpoint;
    var params = {
      "key": 'product-2',
      "prodId": productId,
    };
    var uri = Uri.parse(url).replace(queryParameters: params);
    debugPrint("getProductdetails url : ${uri.toString()}");

    var response = await http.get(uri);
    if (response.statusCode == 200) {
      final List respBody = jsonDecode(response.body)['listing-detail'];

      var product =
          (respBody.map((e) => ProductDetailsModel.fromJson(e)).toList()).first;
      return (product, null);
    } else {
      return (null, Exception(''));
    }
  }
  
  @override
  Future<(List<BrandModel>?, Exception?)> getProductBrands() async{
    var url = baseUrl + mobileAppEndpoint;
    var params = {
      "key": 'get-brands',
    };
    var uri = Uri.parse(url).replace(queryParameters: params);
    debugPrint("getProductBrands url : $uri");
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      final List respBody = jsonDecode(response.body);
      var list = respBody.map((e) => BrandModel.fromJson(e)).toList();
      return (list, null);
    } else {
      return (null, Exception(''));
    }
  }
}
