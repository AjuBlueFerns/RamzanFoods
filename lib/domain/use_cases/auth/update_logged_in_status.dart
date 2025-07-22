import 'package:crocurry/data/repository_impl/auth/auth_repository_impl.dart';

class UpdateLoggedInStatus {
  final AuthRepositoryImpl repository;
  UpdateLoggedInStatus(this.repository);

  Future<void> call(bool value) async {
    return await repository.updateLoggedInStatus(value);
  }
}
