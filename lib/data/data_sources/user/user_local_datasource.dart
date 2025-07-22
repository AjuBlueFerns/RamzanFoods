import 'package:crocurry/data/models/cart_id_model.dart';
import 'package:crocurry/data/models/user_model.dart';
import 'package:crocurry/utils/constants.dart';
import 'package:objectbox/objectbox.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserLocalDatasource {
  /// saves user-details to shared-prefs to retriee when
  /// user is logged-in and opened the app from terminated state
  Future<void> saveUserDetailsToSharedPrefs(UserModel user);

  /// clears the user-details
  Future<void> clearUserDetails();

  /// gets the user-details
  Future<UserModel> getUserDetailsFromSharedPrefs();
  
  // gets the cartid from the object box store for the current-user
  Future<String> getCartIdForUser();

  /// gets the userId of the current user
  Future<String> getUserId();
}

class UserLocalDatasourceImpl extends UserLocalDatasource {
  final Store store;
  UserLocalDatasourceImpl(this.store);

  @override
  Future<void> saveUserDetailsToSharedPrefs(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userNameKey, user.userName ?? "");
    await prefs.setString(firstNameKey, user.firstName ?? "");
    await prefs.setString(lastNameKey, user.lastName ?? "");
    await prefs.setString(emailKey, user.email ?? "");
    await prefs.setString(passwordKey, user.password ?? "");
    await prefs.setString(activationIdKey, user.activationId ?? "");
    await prefs.setString(billingAddressKey, user.billingAddress ?? "");
    await prefs.setString(billingCityKey, user.billingCity ?? "");
    await prefs.setString(billingStateKey, user.billingState ?? "");
    await prefs.setString(billingCountryKey, user.billingCountry ?? "");
    await prefs.setString(billingZipKey, user.billingZip ?? "");
    await prefs.setString(billingTelephoneKey, user.billingTelephone ?? "");
    await prefs.setString(shippingAddressKey, user.shippingAddress ?? "");
    await prefs.setString(shippingCityKey, user.shippingCity ?? "");
    await prefs.setString(shippingStateKey, user.shippingState ?? "");
    await prefs.setString(shippingCountryKey, user.shippingCountry ?? "");
    await prefs.setString(shippingZipKey, user.shippingZip ?? "");
    await prefs.setString(shippingTelephoneKey, user.shippingTelephone ?? "");
    var cartId = await getCartIdForUser();
    if (cartId != "-1") {
      await prefs.setString(cartIdKey, cartId);
    }
  }

  @override
  Future<UserModel> getUserDetailsFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    return UserModel(
      userName: prefs.getString(userNameKey) ?? "",
      firstName: prefs.getString(firstNameKey) ?? "",
      lastName: prefs.getString(lastNameKey) ?? "",
      email: prefs.getString(emailKey) ?? "",
      password: prefs.getString(passwordKey) ?? "",
      activationId: prefs.getString(activationIdKey) ?? "",
      billingAddress: prefs.getString(billingAddressKey),
      billingCity: prefs.getString(billingCityKey),
      billingState: prefs.getString(billingStateKey),
      billingCountry: prefs.getString(billingCountryKey),
      billingZip: prefs.getString(billingZipKey),
      billingTelephone: prefs.getString(billingTelephoneKey),
      shippingAddress: prefs.getString(shippingAddressKey),
      shippingCity: prefs.getString(shippingCityKey),
      shippingCountry: prefs.getString(shippingCountryKey),
      shippingZip: prefs.getString(shippingZipKey),
      shippingState: prefs.getString(shippingStateKey),
      shippingTelephone: prefs.getString(shippingTelephoneKey),
    );
  }

  @override
  Future<void> clearUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  @override
  Future<String> getCartIdForUser() async {
    final prefs = await SharedPreferences.getInstance();

    var userId = prefs.getString(userNameKey);

    var list = store.box<CartIdModel>().getAll();
    var item = list.firstWhere(
      (item) => item.userId == userId,
      orElse: () => CartIdModel('-1', userId),
    );
    return item.cartId!;
  }

  @override
  Future<String> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNameKey) ?? "";
  }
}
