import 'package:crocurry/data/models/user_model.dart';
import 'package:crocurry/domain/api_response.dart';

abstract class UserRepository {
  Future<void> saveUserDetailsToSharedPrefs(UserModel user);
  Future<UserModel> getUserDetailsFromSharedPrefs();
  Future clearUserDetails();
  Future<ApiResponse> updateUserDetails(UserModel user);
}
