import 'package:crocurry/domain/use_cases/user/get_user_details_from_shared.dart';
import 'package:crocurry/utils/locator.dart';
import 'package:crocurry/views/bloc/user/user_event.dart';
import 'package:crocurry/views/bloc/user/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState()) {
    on(fetchUser);
    on(updateUser);
    on(updateStatus);
    on(clearUserDetailsEvent);
  }

  Future fetchUser(FetchUserDetailsFromShared event, Emitter<UserState> emit) async {
    var user = await locator<GetUserDetailsFromShared>().call();
    emit(state.copyWith(userModel: user));
  }

  Future updateUser(UpdateDetails event, Emitter<UserState> emit) async {
    emit(state.copyWith(userModel: event.user, updating: false));
  }

   Future updateStatus(UpdateStatus event, Emitter<UserState> emit) async {
    emit(state.copyWith(updating: event.status));
  }


  Future clearUserDetailsEvent(ClearUserDetailsEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(userModel: null, updating: false));
  }
}
