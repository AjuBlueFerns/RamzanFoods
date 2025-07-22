import 'package:crocurry/data/models/subcategory_model.dart';

class SubcategoryState {
  final bool loading;
  final List<SubcategoryModel> subcategories;
  int selectedIndex;
  SubcategoryState({
    this.loading = true,
    this.subcategories = const [],
    this.selectedIndex = 0,
  });

  SubcategoryState copyWith(
      {bool? isLoading, List<SubcategoryModel>? subcategoryList, int? index}) {
    return SubcategoryState(
      loading: isLoading ?? loading,
      subcategories: subcategoryList ?? subcategories,
      selectedIndex: index ?? selectedIndex,
    );
  }
}
