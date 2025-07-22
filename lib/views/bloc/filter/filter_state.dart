import 'package:crocurry/views/bloc/filter/filter_item.dart';
import 'package:equatable/equatable.dart';

class FilterState {
  final List<FilterType> filterTypes;
  final int selectedFilterIndex;
  final List<String> displayTitles;
  final List<SelectedFilterType>? selectedFilters;
  FilterState({
    List<FilterType>? filterTypes,
    this.displayTitles = const [],
    List<SelectedFilterType>? selectedFilters,
    int? selectedFilterIndex,
  })  : filterTypes = filterTypes ??
            [
              FilterType(
                name: 'Categories',
                key: 'mainCatId',
                isLoading: false,
                filterList: [],
              ),
              FilterType(
                name: 'Sub-Categories',
                key: 'sCatId',
                isLoading: false,
                filterList: [],
              ),
              FilterType(
                name: 'Brands',
                key: 'brand_filter',
                isLoading: false,
                filterList: [],
              ),
              // FilterType(
              //   name: 'Price',
              //   key: 'price_filter',
              //   isLoading: false,
              //   filterList: [],
              // ),
              // FilterType(
              //   name: 'Material',
              //   key: '',
              //   isLoading: false,
              //   filterList: [],
              // ),
              // FilterType(
              //   name: 'Size',
              //   key: '',
              //   isLoading: false,
              //   filterList: [],
              // ),
              // FilterType(
              //   name: 'Colors',
              //   key: '',
              //   isLoading: false,
              //   filterList: [],
              // ),
            ],
        selectedFilterIndex = selectedFilterIndex ?? 0,
        selectedFilters = selectedFilters ?? [];

  FilterState copyWith({
    List<FilterType>? types,
    int? index,
    List<String>? displayList,
    List<SelectedFilterType>? selected,
  }) {
    return FilterState(
      filterTypes: types ?? filterTypes,
      selectedFilterIndex: index ?? selectedFilterIndex,
      displayTitles: displayList ?? displayTitles,
      selectedFilters: selected ?? selectedFilters,
    );
  }

  @override
  List<Object?> get props => [
        filterTypes,
        selectedFilterIndex,
        selectedFilters,
        displayTitles,
      ];

  FilterType get selectedFilter => filterTypes.firstWhere(
      (filter) => filter.name == filterTypes[selectedFilterIndex].name);

  // List<FilterType> get selectedFilters1 =>
  //     filterTypes.where((filter) => filter.selectedIndex != -1).toList();

  List<FilterDetailsItem> getAppliedFilters() {
    var list = <FilterDetailsItem>[];
    for (var type in filterTypes) {
      var index = type.selectedIndex;
      if (type.filterList.isNotEmpty && index != -1) {
        list.add(type.filterList[index]);
      }
    }
    return list;
  }

  List<FilterType> getAppliedFilterTypes() {
    var list = <FilterType>[];
    for (var type in filterTypes) {
      var index = type.selectedIndex;
      if (type.filterList.isNotEmpty && index != -1) {
        list.add(type);
      }
    }
    return list;
  }

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = {};
    for (var type in filterTypes) {
      // var index = type.selectedIndex;
      if (type.filterList.isNotEmpty && type.selectedIndex != -1) {
        params.addAll({
          type.key: type.filterList[type.selectedIndex].value,
        });
      }
    }
    return params;
  }
}
