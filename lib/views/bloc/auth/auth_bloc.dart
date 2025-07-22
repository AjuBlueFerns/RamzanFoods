import 'package:crocurry/domain/use_cases/auth/check_logged_in.dart';
import 'package:crocurry/domain/use_cases/auth/update_logged_in_status.dart';
import 'package:crocurry/domain/use_cases/cart/clear_cart_id.dart';
import 'package:crocurry/domain/use_cases/user/clear_user_details.dart';
import 'package:crocurry/utils/locator.dart';
import 'package:crocurry/views/bloc/auth/auth_event.dart';
import 'package:crocurry/views/bloc/auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState()) {
    on<LogIn>(login);
    on<LogOut>(logout);
    on(checkLoggedIn);
    on(otpLoadingStatus);
    on(otpVerifyingStatus);
  }

  Future<void> login(LogIn event, Emitter<AuthState> emit) async {
    /// updates loggedInKey in shared prefs to true
    await locator<UpdateLoggedInStatus>().call(true);
    emit(state.copyWith(status: true));
  }

  Future<void> logout(LogOut event, Emitter<AuthState> emit) async {
    /// updates loggedInKey in shared prefs to false
    await locator<UpdateLoggedInStatus>().call(false);

    /// removes cartIdKey from shared prefs
    /// removes cartid-userId item from  the object-box store database
    await locator<ClearCartId>().call();
    await locator<ClearUserDetails>().call();

    emit(state.copyWith(status: false));
  }

  Future<void> checkLoggedIn(_, Emitter<AuthState> emit) async {
    var status = await locator<CheckLoggedIn>().call();
    emit(state.copyWith(status: status));
  }

  Future<void> otpLoadingStatus(
      OtpLoading event, Emitter<AuthState> emit) async {
    emit(state.copyWith(otpSending: event.status));
  }

  Future<void> otpVerifyingStatus(
      OtpVerifying event, Emitter<AuthState> emit) async {
    emit(state.copyWith(verifying: event.status));
  }
}
