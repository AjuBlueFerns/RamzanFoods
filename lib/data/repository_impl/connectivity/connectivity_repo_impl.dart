import 'package:crocurry/domain/repository/connectivity/connectivity_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityRepositoryImpl implements ConnectivityRepository {
  @override
  Future<bool> isConnected() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return (!connectivityResult.contains(ConnectivityResult.none));
  }
}
