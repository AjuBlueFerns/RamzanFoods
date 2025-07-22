import 'package:crocurry/views/bloc/validator/validator_event.dart';
import 'package:crocurry/views/bloc/validator/validator_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ValidatorBloc extends Bloc<ValidatorEvent, ValidatorState> {
  ValidatorBloc() : super(ValidatorState()) {
    on(setValidationMsg);
    on(clearValidationMsgEvent);
  }

  Future setValidationMsg(
      SetValidationMsgEvent event, Emitter<ValidatorState> emit) async{
    emit(state.copyWith(msg: event.msg));
  }

   Future clearValidationMsgEvent(
      ClearValidationMsgEvent event, Emitter<ValidatorState> emit) async{
    emit(state.copyWith(msg: ""));
  }
}
