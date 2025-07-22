import 'package:crocurry/data/models/product_model.dart';

abstract class BookmarkEvent {}

class AddProductToBookmark extends BookmarkEvent {
  final ProductModel product;
  AddProductToBookmark(this.product);
}

class RemoveProductFromBookmark extends BookmarkEvent {
  final ProductModel product;
  RemoveProductFromBookmark(this.product);
}

class GetBookmarksList extends BookmarkEvent {
  String userName;
  GetBookmarksList(this.userName);
}
