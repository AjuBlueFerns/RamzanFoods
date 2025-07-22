import 'package:crocurry/data/models/category_model.dart';

class CategoryState {
  final bool loading;
  final List<CategoryModel> categories;
  final int selectedCategoryIndex;
  final String selectedCategoryId;
  CategoryState({
    this.categories = const [],
    this.loading = true,
    this.selectedCategoryIndex = 0,
    this.selectedCategoryId = "",
  });

  CategoryState copyWith(
      {List<CategoryModel>? categoryList,
      bool? isLoading,
      int? index,
      String? id}) {
    return CategoryState(
      loading: isLoading ?? loading,
      categories: categoryList ?? categories,
      selectedCategoryIndex: index ?? selectedCategoryIndex,
      selectedCategoryId: id ?? selectedCategoryId,
    );
  }

  CategoryModel get selectedCategory => categories.firstWhere(
        (category) => category.mainCategoryId! == selectedCategoryId,
        orElse: () => categories.first,
      );
}
