import 'package:crocurry/data/models/user_model.dart';
import 'package:crocurry/data/repository_impl/auth/auth_repository_impl.dart';

class VerifyOtp {
  final AuthRepositoryImpl repository;
  VerifyOtp(this.repository);

  Future<(UserModel?, Exception?)> call(
      String mobile, String otp, String hashKey) async {
    return await repository.verifyOtp(mobile, otp, hashKey);
  }
}
