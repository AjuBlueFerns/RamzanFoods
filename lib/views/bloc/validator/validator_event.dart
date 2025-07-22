abstract class ValidatorEvent {}

class SetValidationMsgEvent extends ValidatorEvent {
  String msg;
  SetValidationMsgEvent(this.msg);
}

class ClearValidationMsgEvent extends ValidatorEvent {
  ClearValidationMsgEvent();
}
