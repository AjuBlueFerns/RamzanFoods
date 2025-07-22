abstract class AuthEvent {}

class LogIn extends AuthEvent {}

class LogOut extends AuthEvent {}

class OtpLoading extends AuthEvent {
  final bool status;
  OtpLoading(this.status);
}

class OtpVerifying extends AuthEvent {
  final bool status;
  OtpVerifying(this.status);
}
