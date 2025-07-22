import 'package:crocurry/data/data_sources/auth/auth_local_datasource.dart';
import 'package:crocurry/data/data_sources/auth/auth_remote_datasource.dart';
import 'package:crocurry/data/models/user_model.dart';
import 'package:crocurry/domain/repository/auth/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDatasourceImpl remoteDatasource;
  final AuthLocalDatasourceImpl localDatasource;
  AuthRepositoryImpl(
    this.remoteDatasource,
    this.localDatasource,
  );

  @override
  Future<(String?, Exception?)> getOtp(String mobile) async {
    String? hash;
    Exception? exc;
    try {
      var result = await remoteDatasource.getOtp(mobile);
      if (result.$1 != null && result.$1!.isNotEmpty) {
        hash = result.$1!;
      }
    } catch (err) {
      exc = Exception(err);
    }
    return (hash, exc);
  }

  @override
  Future<(UserModel?, Exception?)>  verifyOtp(
      String mobile, String otp, String hashKey) async {
    UserModel? user;
    Exception? exc;
    try {
      var result = await remoteDatasource.verifyOtp(mobile, otp, hashKey);
      user = result.$1!;
    } catch (err) {
      exc = Exception(err);
    }
    return (user, exc);
  }

  @override
  Future<bool> checkLoggedIn() async {
    return await localDatasource.checkLoggedIn();
  }

  @override
  Future<void> updateLoggedInStatus(bool value) async {
    /// value === true => login
    /// value === false => logout
    return await localDatasource.updateLoggedInStatus(value);
  }
}
