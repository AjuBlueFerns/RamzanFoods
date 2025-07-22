import 'package:crocurry/domain/repository/connectivity/connectivity_repository.dart';

class CheckConnectivity {
  final ConnectivityRepository repository;

  CheckConnectivity(this.repository);

  Future<bool> call() async {
    return await repository.isConnected();
  }
}