class ScreenState {
  final int selectedIndex;
  final bool searchMode;
  ScreenState({
    this.searchMode = false,
    this.selectedIndex = 0,
  });

  ScreenState copyWith({int? index, bool? search}) {
    return ScreenState(
      selectedIndex: index ?? selectedIndex,
      searchMode: search ?? searchMode,
    );
  }
}
