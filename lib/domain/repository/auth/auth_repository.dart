import 'package:crocurry/data/models/user_model.dart';

abstract class AuthRepository {
  Future<(String?, Exception?)> getOtp(String mobile);
  Future<(UserModel?, Exception?)> verifyOtp(
      String mobile, String otp, String hashKey);
  Future<bool> checkLoggedIn();
  Future<void> updateLoggedInStatus(bool value);
}
