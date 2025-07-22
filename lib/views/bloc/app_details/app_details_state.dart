class AppDetailsState {
  String buildNumber;
  String versionNumber;
  AppDetailsState({
    this.buildNumber = "",
    this.versionNumber = "",
  });

  AppDetailsState copyWith({String? version, String? build}) {
    return AppDetailsState(
      versionNumber: version?? versionNumber,
      buildNumber: build?? buildNumber,
    );
  }
}
