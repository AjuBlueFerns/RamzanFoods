import 'package:crocurry/data/repository_impl/auth/auth_repository_impl.dart';

class CheckLoggedIn {
  final AuthRepositoryImpl repository;
  CheckLoggedIn(this.repository);

  Future<bool> call() async {
    return await repository.checkLoggedIn();
  }
}
