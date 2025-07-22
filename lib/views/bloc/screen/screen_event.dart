abstract class ScreenEvent {}

class UpdateScreenIndex extends ScreenEvent {
  final int index;
  UpdateScreenIndex({
    required this.index,
  });
}

class UpdateSearchMode extends ScreenEvent {
  final bool status;
  UpdateSearchMode(this.status);
}
