import 'package:crocurry/data/models/user_model.dart';
import 'package:crocurry/data/repository_impl/user/user_repository_impl.dart';

class GetUserDetailsFromShared {
  final UserRepositoryImpl repository;
  GetUserDetailsFromShared(this.repository);
  Future<UserModel> call() async {
    return await repository.getUserDetailsFromSharedPrefs();
  }
}
