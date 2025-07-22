import 'package:crocurry/data/models/user_model.dart';
import 'package:crocurry/data/repository_impl/user/user_repository_impl.dart';

class UpdateUserDetails {
  final UserRepositoryImpl repository;
  UpdateUserDetails(this.repository);

  Future call(UserModel user) async {
    return await repository.updateUserDetails(user);
  }
}
