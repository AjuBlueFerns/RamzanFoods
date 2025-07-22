class FilterType {
  String name;
  bool isLoading;
  int selectedIndex;
  String key;

  List<FilterDetailsItem> filterList;
  FilterType({
    required this.key,
    required this.filterList,
    required this.isLoading,
    required this.name,
    this.selectedIndex = -1,
  });
}

class SelectedFilterType {
  String name;
  bool isLoading;
  int selectedIndex;
  String key;

  FilterDetailsItem filterItem;
  SelectedFilterType({
    required this.key,
    required this.filterItem,
    required this.isLoading,
    required this.name,
    this.selectedIndex = -1,
  });
}

class FilterDetailsItem {
  String displayName;
  String id;
  String value;
  FilterDetailsItem(
    this.displayName,
    this.id,
    this.value,
  );
}
