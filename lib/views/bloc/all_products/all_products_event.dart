abstract class AllProductsEvent {}

class FetchAllProducts extends AllProductsEvent {
  final String? pageSize;
  final String? pageNumber;
  final String? categoryId;
  final String? subCategoryId;
  final String? key;
  final bool clearProducts;
  FetchAllProducts({
    this.pageSize,
    this.key,
    this.pageNumber,
    this.categoryId,
    this.subCategoryId,
    this.clearProducts = false,
  });
}

class FetchAllProductsWithParams extends AllProductsEvent {
  final String? pageSize;
  final String? pageNumber;
  final String? key;
  final bool clearProducts;
  final Map<String, dynamic> params;
  FetchAllProductsWithParams({
    this.pageSize,
    this.key,
    this.pageNumber,
    this.clearProducts = false,
    this.params = const {},
  });
}

class ClearProductList extends AllProductsEvent {}
