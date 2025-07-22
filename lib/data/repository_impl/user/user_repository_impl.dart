import 'package:crocurry/data/data_sources/user/user_local_datasource.dart';
import 'package:crocurry/data/data_sources/user/user_remote_datasource.dart';
import 'package:crocurry/data/models/user_model.dart';
import 'package:crocurry/domain/api_response.dart';
import 'package:crocurry/domain/repository/user/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserLocalDatasourceImpl localDatasource;
  final UserRemotedataSourceImpl remotedataSource;
  UserRepositoryImpl({
    required this.localDatasource,
    required this.remotedataSource,
  });
  @override
  Future<void> saveUserDetailsToSharedPrefs(UserModel user) async {
    await localDatasource.saveUserDetailsToSharedPrefs(user);
  }

  @override
  Future<UserModel> getUserDetailsFromSharedPrefs() async {
    return await localDatasource.getUserDetailsFromSharedPrefs();
  }

  @override
  Future clearUserDetails() async {
    return await localDatasource.clearUserDetails();
  }

  @override
  Future<ApiResponse> updateUserDetails(UserModel user) async {
    try {
      await remotedataSource.updateUserdetails(user);
      await localDatasource.saveUserDetailsToSharedPrefs(user);
      return ApiResponse.success('Success');
    } catch (err) {
      return ApiResponse.failure(err.toString());
    }
  }
}
