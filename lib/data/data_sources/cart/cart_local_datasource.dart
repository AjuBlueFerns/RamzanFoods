import 'package:crocurry/data/models/cart_id_model.dart';
import 'package:crocurry/objectbox.g.dart';
import 'package:crocurry/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// class for performing cart functions using the ObjectBox database
abstract class CartLocalDatasource {
  /// returns the current cart of the user
  Future<String> getCartId();
  /// sets the cartid received from api after an item has been added to cart
  /// to sharedprefs and objectbox store
  Future<void> addCartId(String id);
  /// clears the cart id after  proceeding to payment
  Future<void> clearCartId();
}

class CartLocalDatasourceImpl extends CartLocalDatasource {
  final Store store;
  CartLocalDatasourceImpl(this.store);

  @override
  Future<void> addCartId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(cartIdKey, id);
    var userId = prefs.getString(userNameKey);
    store.box<CartIdModel>().put(CartIdModel(id, userId));
  }

  @override
  Future<String> getCartId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(cartIdKey) ?? '';
  }

  @override
  Future<void> clearCartId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(cartIdKey);
    var userId = prefs.getString(userNameKey);
    var list = store.box<CartIdModel>().getAll();
    var item = list.firstWhere(
      (item) => item.userId == userId,
      orElse: () => CartIdModel('-1', userId),
    );
    if (item.cartId! != "-1") {
      store.box<CartIdModel>().remove(item.id);
    }
  }
}
