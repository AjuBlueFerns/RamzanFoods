class ValidatorState {
  String message;
  ValidatorState({
    this.message = "",
  });

  ValidatorState copyWith({String? msg}) {
    return ValidatorState(message: msg ?? message);
  }
}
