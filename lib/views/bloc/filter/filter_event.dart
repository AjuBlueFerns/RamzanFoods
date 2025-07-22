import 'package:crocurry/data/models/category_model.dart';
import 'package:crocurry/views/bloc/filter/filter_item.dart';

abstract class FilterEvent {}

class InitCategoryFilter extends FilterEvent {
  List<CategoryModel> categories;
  InitCategoryFilter(this.categories);
}

class UpdateFilterIndex extends FilterEvent {
  int index;
  UpdateFilterIndex(this.index);
}

class UpdateFilterList extends FilterEvent {
  FilterType item;
  String id;
  UpdateFilterList(this.item, this.id);
}

class UpdateFilterListIndex extends FilterEvent {
  int index;
  UpdateFilterListIndex(this.index);
}

// class UpdateDisplayTitles extends FilterEvent {
//   List<String> list;
//   UpdateDisplayTitles(this.list);
// }

class ClearFiltersEvent extends FilterEvent {
  ClearFiltersEvent();
}

class RemoveFilterEvent extends FilterEvent {
  SelectedFilterType filter;
  RemoveFilterEvent(this.filter);
}

class UpdateSelectedFiltersEvent extends FilterEvent {
//  final List<FilterType> list;
  UpdateSelectedFiltersEvent();
}
