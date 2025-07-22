import 'package:crocurry/data/repository_impl/auth/auth_repository_impl.dart';

class GetOtp {
  final AuthRepositoryImpl repository;
  GetOtp(this.repository);

  Future<(String?, Exception?)> call(String mobile) async {
    return await repository.getOtp(mobile);
  }
}
