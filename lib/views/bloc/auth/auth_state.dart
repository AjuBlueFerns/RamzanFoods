class AuthState {
  final bool isLoggedIn;
  final bool isOtpSending;
  final bool isOtpVerifiying;
  AuthState({
    this.isLoggedIn = false,
    this.isOtpSending = false,
    this.isOtpVerifiying = false,
  });

  AuthState copyWith({bool? status, bool? otpSending, bool? verifying}) {
    return AuthState(
      isLoggedIn: status ?? isLoggedIn,
      isOtpSending: otpSending ?? isOtpSending,
      isOtpVerifiying: verifying?? isOtpVerifiying,
    );
  }
}
