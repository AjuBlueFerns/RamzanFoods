import 'package:crocurry/data/models/product_model.dart';
import 'package:crocurry/domain/use_cases/product/add_bookmark.dart';
import 'package:crocurry/domain/use_cases/product/get_bookmarks.dart';
import 'package:crocurry/domain/use_cases/product/remove_bookmark.dart';
import 'package:crocurry/utils/locator.dart';
import 'package:crocurry/views/bloc/bookmark/bookmark_event.dart';
import 'package:crocurry/views/bloc/bookmark/bookmark_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  BookmarkBloc() : super(BookmarkState()) {
    on(addBookmark);
    on(removeBookmark);
    on(getList);
  }

  addBookmark(AddProductToBookmark event, Emitter<BookmarkState> emit) {
    locator<AddBookmark>().call(event.product);
    List<ProductModel> newList = List.from(state.products);
    debugPrint("### newlist length b4 :${newList.length}");

    newList.add(event.product);
    debugPrint("### newlist length :${newList.length}");
    emit(state.copyWith(list: newList));
  }

  removeBookmark(RemoveProductFromBookmark event, Emitter<BookmarkState> emit) {
    locator<RemoveBookmark>().call(event.product.id);
    List<ProductModel> newList = List.from(state.products);

    newList.removeWhere((prod) => prod.productId! == event.product.productId!);
    emit(state.copyWith(list: newList));
  }

  Future getList(GetBookmarksList event, Emitter<BookmarkState> emit) async {
    var list = await locator<GetBookmarks>().call(event.userName);
    debugPrint(" ### list length :: ${list.length}");
    emit(state.copyWith(list: list));

    // store.runInTransaction(TxMode.write, () {
    //   store.box<ProductModel>().put(event.product);
    // });
    // store.runInTransaction((_) {
    //   store.box<FavoriteItem>().put(favoriteItem);
    // });
  }
}
