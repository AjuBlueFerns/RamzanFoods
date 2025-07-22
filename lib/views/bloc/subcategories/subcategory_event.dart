abstract class SubcategoryEvent {}

class FetchSubcategories extends SubcategoryEvent {
  final String category;
  FetchSubcategories({
    required this.category,
  });
}

class UpdateSubCategoryIndex extends SubcategoryEvent {
  final int index;
  UpdateSubCategoryIndex({required this.index});
}
