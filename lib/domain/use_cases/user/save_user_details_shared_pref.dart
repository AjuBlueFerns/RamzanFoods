import 'package:crocurry/data/models/user_model.dart';
import 'package:crocurry/data/repository_impl/user/user_repository_impl.dart';

class SaveUserDetailsSharedPref {
  final UserRepositoryImpl repository;
  SaveUserDetailsSharedPref({required this.repository});

  Future call(UserModel user) async {
    await repository.saveUserDetailsToSharedPrefs(user);
  }
}
