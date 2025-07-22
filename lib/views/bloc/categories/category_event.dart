import 'package:crocurry/data/models/category_model.dart';

abstract class CategoryEvent {}

class FetchCategories extends CategoryEvent {
  List<CategoryModel> categories;
  FetchCategories(
    this.categories,
  );
}
