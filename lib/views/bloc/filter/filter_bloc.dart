import 'package:crocurry/domain/use_cases/product/get_brands.dart';
import 'package:crocurry/domain/use_cases/product/get_subcategories.dart';
import 'package:crocurry/utils/locator.dart';
import 'package:crocurry/views/bloc/filter/filter_event.dart';
import 'package:crocurry/views/bloc/filter/filter_item.dart';
import 'package:crocurry/views/bloc/filter/filter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(FilterState()) {
    /// to update selection  of filter-names under view on left
    on(updateIndex);

    /// to init category from categories list fetched before
    on(initCategory);

    /// to update filters list by calling their api
    on(updateList);

    /// to update selected filters-values index on right
    on(updateFilterListIndex);

    /// to display selected filters in appbar
    // on(updateDisplayTitles);

    /// to clear all filters
    on(clearFiltersEvent);

    /// to remove a specific filter
    on(removeFilterEvent);

    /// to add filters to display selected filters in appbar
    on(updateSelectedFiltersEvent);
  }

  initCategory(InitCategoryFilter event, Emitter<FilterState> emit) async {
    // final details = await locator<GetProductCategories>().call();
    var filterList = state.filterTypes;
    // var categoryList = details.$1 ?? [];
    var categoryList = event.categories;

    var categoryIndex = 0;
    filterList[categoryIndex].filterList = categoryList
        .map((category) => FilterDetailsItem(
              category.productCategoryName!,
              category.mainCategoryId!,
              category.mainCategoryId!,
            ))
        .toList();
    emit(state.copyWith(types: filterList));
  }

  updateIndex(UpdateFilterIndex event, Emitter<FilterState> emit) async {
    var types = state.filterTypes;
    if (event.index == 1) {
      types[1].isLoading = true;
      emit(state.copyWith(types: types));
      var subCatList = types[1].filterList;

      /// to remove subcat list when no categories is selected
      if (types[0].selectedIndex == -1) {
        subCatList = [];
      } else {
        if (subCatList.isEmpty && state.getAppliedFilters().isNotEmpty) {
          var id = state.getAppliedFilters()[0].id;
          final response = await locator<GetSubCategories>().call(id);
          subCatList = (response.$1 ?? [])
              .map((subcat) => FilterDetailsItem(
                    subcat.productCategoryName!,
                    subcat.prodCategoryId!,
                    subcat.prodCategoryId!,
                  ))
              .toList();
        }
      }

      types[1].isLoading = false;

      types[1].filterList = subCatList;
      // types[1].selectedIndex = 0;
      emit(state.copyWith(types: types, index: 1));
    } else if (event.index == 2) {
      // var index = types.indexWhere((filter) => filter.name == 'Sub-Categories');
      types[2].isLoading = true;
      emit(state.copyWith(types: types));
      var brandsList = types[2].filterList;
      if (brandsList.isEmpty) {
        final response = await locator<GetBrands>().call();
        brandsList = (response.$1 ?? [])
            .map((brand) => FilterDetailsItem(
                  brand.brandName!,
                  brand.brandId!,
                  brand.brandId!,
                ))
            .toList();
        brandsList.sort((a, b) => a.displayName.compareTo(b.displayName));
      }
      types[2].isLoading = false;

      types[2].filterList = brandsList;
      // types[2].selectedIndex = 0;

      emit(state.copyWith(types: types, index: 2));
    }
    emit(state.copyWith(index: event.index));
  }

  updateList(UpdateFilterList event, Emitter<FilterState> emit) async {
    var types = state.filterTypes;
    // var types1 = state.selectedFilters;

    if (event.item.name == "Categories" && types[0].selectedIndex != -1) {
      var index = 1;
      types[index].isLoading = true;
      emit(state.copyWith(types: types));
      final response = await locator<GetSubCategories>().call(event.id);
      types[index].isLoading = false;
      var subCatList = (response.$1 ?? [])
          .map((subcat) => FilterDetailsItem(
                subcat.productCategoryName!,
                subcat.prodCategoryId!,
                subcat.prodCategoryId!,
              ))
          .toList();
      types[index].filterList = subCatList;
      // types[index].selectedIndex = 0;
      emit(state.copyWith(types: types, index: index));
    }
  }

  updateFilterListIndex(
      UpdateFilterListIndex event, Emitter<FilterState> emit) async {
    var types = state.filterTypes;
    // var types1 = state.selectedFilters;
    var typeIndex = state.selectedFilterIndex;

    if (event.index == types[typeIndex].selectedIndex) {
      types[typeIndex].selectedIndex = -1;
    } else {
      types[typeIndex].selectedIndex = event.index;
    }
    emit(state.copyWith(
      types: types,
    ));
  }

  // updateDisplayTitles(
  //     UpdateDisplayTitles event, Emitter<FilterState> emit) async {
  //   emit(state.copyWith(displayList: event.list));
  // }

  clearFiltersEvent(ClearFiltersEvent event, Emitter<FilterState> emit) async {
    var list = state.filterTypes;
    for (var i in list) {
      i.selectedIndex = -1;
    }
    emit(state.copyWith(types: list));
  }

  removeFilterEvent(RemoveFilterEvent event, Emitter<FilterState> emit) async {
    var list = state.filterTypes;

    var index = list.indexWhere((filter) => filter.name == event.filter.name);

    /// to unselect the filter
    list[index].selectedIndex = -1;
    var selected = state.selectedFilters ?? [];
    selected.removeWhere((filter) =>
        filter.filterItem.displayName == event.filter.filterItem.displayName);
    emit(state.copyWith(types: list, selected: selected));
  }

  updateSelectedFiltersEvent(
      UpdateSelectedFiltersEvent event, Emitter<FilterState> emit) async {
    var list = state.getAppliedFilterTypes()
        .map((filter) => SelectedFilterType(
            key: filter.key,
            filterItem: filter.filterList[filter.selectedIndex],
            isLoading: false,
            name: filter.name))
        .toList();
    emit(state.copyWith(selected: list));
  }
}
