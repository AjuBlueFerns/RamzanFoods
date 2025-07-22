import 'package:crocurry/data/models/product_model.dart';
import 'package:crocurry/domain/use_cases/product/get_products.dart';
import 'package:crocurry/utils/extensions/string_extensions.dart';
import 'package:crocurry/utils/locator.dart';
import 'package:crocurry/views/bloc/search/search_event.dart';
import 'package:crocurry/views/bloc/search/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState()) {
    on(doSearch);
    on(clearList);
  }

  Future doSearch(PerformSearch event, Emitter<SearchState> emit) async {
    /// prevent api from calling multiple times at a time
    if (!state.isLoading) {
      var loadingList = state.searchResults;

      /// set to empty-list for showing first page, or the current list
      emit(state.copyWith(
        loading: true,
        items: event.page == "1" ? [] : loadingList,
      ));

      var params = {
        'key': 'pdt-list2',
        'searchStr': event.text,
      };
      await Future.delayed(const Duration(milliseconds: 500));

      // final details = await locator<GetProducts>().call(params, "10", '1');
      var pageSize = event.pageSize ?? "10";
      final details = await locator<GetProducts>().call(
        params,
        pageSize,
        event.page ?? (state.pageNumber + 1).toString(),
      );
      var list = state.searchResults;

      /// remove loading items marked at end of list
      list.removeWhere((item) => item.productId == "loading");

      var apiList = details.$1;
      debugPrint("length b4 ${list.length}");

      if (apiList != null) {
        debugPrint("length from api ${apiList.length}");

        /// append list from api at the end of current list
        list = [...list, ...apiList];
      }
      debugPrint("length after ${list.length}");

      /// increment page-number , or current page-number
      var page = apiList != null
          ? int.parse(event.page ?? (state.pageNumber + 1).toString())
          : state.pageNumber;

      if (apiList != null && apiList.length == pageSize.toInt()) {
        ///  for showing loading in listview as list index
        list.add(ProductModel(productId: 'loading'));
        list.add(ProductModel(productId: 'loading'));
      }

      emit(state.copyWith(
        loading: false,
        page: page,
        items: list,
      ));
    }
  }

  Future clearList(ClearSearchList event, Emitter<SearchState> emit) async {
    emit(state.copyWith(loading: false, items: []));
  }
}
