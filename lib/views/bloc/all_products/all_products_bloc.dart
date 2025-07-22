import 'package:crocurry/data/models/product_model.dart';
import 'package:crocurry/domain/use_cases/product/get_products.dart';
import 'package:crocurry/utils/extensions/string_extensions.dart';
import 'package:crocurry/utils/locator.dart';
import 'package:crocurry/views/bloc/all_products/all_products_event.dart';
import 'package:crocurry/views/bloc/all_products/all_products_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllProductsBloc extends Bloc<AllProductsEvent, AllProductsState> {
  AllProductsBloc() : super(AllProductsState()) {
    on(getAllProducts);
    on(clearProducts);
    on(getAllProductsWithParams);
  }

  Future getAllProducts(
      FetchAllProducts event, Emitter<AllProductsState> emit) async {
    /// clear products before loading
    if (event.clearProducts) {
      emit(state.copyWith(loading: false, productList: [], page: 1));
    }

    /// prevent api from calling multiple times at a time
    if (!state.isLoading) {
      emit(state.copyWith(
        loading: true,
        productList: event.pageNumber == "1" ? [] : state.products,
      ));
      var params = {
        'key': event.key ?? "pdt-list2",
        'mainCatId': event.categoryId ?? state.categoryId,
        'sCatId': event.subCategoryId ?? state.subCategoryId,
      };

      await Future.delayed(const Duration(milliseconds: 500));

      /// set pageSize to 10 if null
      var pageSize = event.pageSize ?? "10";

      final details = await locator<GetProducts>().call(params, event.pageSize,
          event.pageNumber ?? (state.pageNumber + 1).toString());
      var list = state.products;
      var apiList = details.$1;

      /// remove loading items marked at end of list
      list.removeWhere((item) => item.productId == "loading");

      // debugPrint("length b4 ${list.length}");

      if (details.$1 != null) {
        /// append list from api at the end of current list
        list = [...list, ...details.$1!];
      }
      debugPrint("length after ${list.length}");

      /// increment page-number , or current page-number
      var page = details.$1 != null
          ? int.parse(event.pageNumber ?? (state.pageNumber + 1).toString())
          : state.pageNumber;
      if (apiList != null && apiList.length == pageSize.toInt()) {
        ///  for showing loading in listview as list index
        list.add(ProductModel(productId: 'loading'));
        list.add(ProductModel(productId: 'loading'));
      }
      emit(state.copyWith(
        loading: false,
        page: page,
        productList: list,
        catId: event.categoryId ?? state.categoryId,
        subCatId: event.subCategoryId ?? state.subCategoryId,
      ));
    }
  }

  void clearProducts(ClearProductList event, Emitter<AllProductsState> emit) {
    emit(state.copyWith(loading: false, productList: [], page: 1));
  }

  Future getAllProductsWithParams(
      FetchAllProductsWithParams event, Emitter<AllProductsState> emit) async {
    /// clear products before loading
    if (event.clearProducts) {
      emit(state.copyWith(loading: false, productList: [], page: 1));
    }

    /// prevent api from calling multiple times at a time
    if (!state.isLoading) {
      emit(state.copyWith(
        loading: true,
        productList: event.pageNumber == "1" ? [] : state.products,
      ));
      Map<String,dynamic> params = {
        'key': event.key ?? "pdt-list2",
      };
      params.addAll(event.params);

      await Future.delayed(const Duration(milliseconds: 500));

      /// set pageSize to 10 if null
      var pageSize = event.pageSize ?? "10";

      final details = await locator<GetProducts>().call(params, event.pageSize,
          event.pageNumber ?? (state.pageNumber + 1).toString());
      var list = state.products;
      var apiList = details.$1;

      /// remove loading items marked at end of list
      list.removeWhere((item) => item.productId == "loading");

      // debugPrint("length b4 ${list.length}");

      if (details.$1 != null) {
        /// append list from api at the end of current list
        list = [...list, ...details.$1!];
      }
      debugPrint("length after ${list.length}");

      /// increment page-number , or current page-number
      var page = details.$1 != null
          ? int.parse(event.pageNumber ?? (state.pageNumber + 1).toString())
          : state.pageNumber;
      if (apiList != null && apiList.length == pageSize.toInt()) {
        ///  for showing loading in listview as list index
        list.add(ProductModel(productId: 'loading'));
        list.add(ProductModel(productId: 'loading'));
      }
      emit(state.copyWith(
        loading: false,
        page: page,
        productList: list,
      ));
    }
  }
}
