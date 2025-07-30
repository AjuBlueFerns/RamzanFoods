import 'package:crocurry/data/models/product_model.dart';
import 'package:crocurry/domain/use_cases/product/get_products.dart';
import 'package:crocurry/utils/locator.dart';
import 'package:crocurry/views/bloc/products/product_event.dart';
import 'package:crocurry/views/bloc/products/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductState()) {
    on(getProducts);
  }

  Future<void> getProducts(
      FetchProducts event, Emitter<ProductState> emit) async {
    var index = event.index ?? 0;
    List<bool> updatedLoadingList = List.from(state.loading)..[index] = true;

    List<List<ProductModel>> updatedProductLists = List.from(state.products)
      ..[index] = [];

    emit(state.copyWith(
      isLoading: updatedLoadingList,
      productList: updatedProductLists,
    ));
    debugPrint(
        " @@ index $index products list length @before :: ${updatedProductLists[index].length}");
    var params = {
      'key': event.key,
    };
    if (event.categoryId != null) {
      params.addAll({'mainCatId': event.categoryId!});
    }
    if (event.subCategoryId != null) {
      params.addAll({'sCatId': event.subCategoryId!});
    }
    if (event.searchStr != null) {
      params.addAll({'searchStr': event.searchStr!});
    }
    if (event.filterKey != null) {
      params.addAll({'filterKey': event.filterKey!});
    }
    
    final details = await locator<GetProducts>()
        .call(params, event.pageSize, event.pageNumber!);

    updatedLoadingList = List.from(state.loading)..[index] = false;

    updatedProductLists = List.from(state.products)..[index] = details.$1 ?? [];
    // debugPrint(
    //     " @@ products list length @after :: ${updatedProductLists[index].length}");
    if (updatedProductLists[index].isNotEmpty) {
      // debugPrint(
      //     " @@ products friendlyName :: ${updatedProductLists[index].first.friendlyName!}");
    }

    emit(state.copyWith(
      isLoading: updatedLoadingList,
      productList: updatedProductLists,
    ));
  }
}
