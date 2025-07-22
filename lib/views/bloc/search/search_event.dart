abstract class SearchEvent {}

class PerformSearch extends SearchEvent {
  final String text;
  final String? page;
  final String? pageSize;
  PerformSearch({required this.text, this.page, this.pageSize});
}

class ClearSearchList extends SearchEvent {
  ClearSearchList();
}
