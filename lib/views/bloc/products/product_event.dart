abstract class ProductEvent {}

class FetchProducts extends ProductEvent {
// final Map<String, dynamic>? params;
  final String? pageSize;
  final String? pageNumber;
  final String? categoryId;
  final String? subCategoryId;
  final String key;
  final String? searchStr;
  final String? filterKey;
  final int? index;
  FetchProducts({
    // this.params,
    this.index,
    this.pageSize,
    required this.key,
    this.pageNumber,
    this.categoryId,
    this.subCategoryId,
    this.filterKey,
    this.searchStr,
  });
}
