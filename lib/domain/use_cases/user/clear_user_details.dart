import 'package:crocurry/data/repository_impl/user/user_repository_impl.dart';

class ClearUserDetails {
  final UserRepositoryImpl repository;
  ClearUserDetails(this.repository);
  Future call() async {
    return await repository.clearUserDetails();
  }
}
