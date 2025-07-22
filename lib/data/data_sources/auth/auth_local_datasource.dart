import 'package:crocurry/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// class for auth functions in local
abstract class AuthLocalDatasource {
  /// to check whether user is logged in
  /// by using isLoggedInKey from sharedPrefs
  Future<bool> checkLoggedIn();

  /// to update the value of isLoggedInKey from sharedPrefs
  Future<void> updateLoggedInStatus(bool value);
}

class AuthLocalDatasourceImpl extends AuthLocalDatasource {
  @override
  Future<bool> checkLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isLoggedInKey) ?? false;
  }

  @override
  Future<void> updateLoggedInStatus(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isLoggedInKey, value);
  }
}
