import 'package:crocurry/data/models/cart_details_model.dart';

class DataSources {
  // ✅ Private constructor
  DataSources._internal();

  // ✅ Single instance (created lazily only once)
  static final DataSources _instance = DataSources._internal();

  // ✅ Public getter to access the instance
  factory DataSources() => _instance;

  CartDetailsModel _cartDetailsModel = CartDetailsModel();
  CartDetailsModel get cartDetailsModel => _cartDetailsModel;

  void setCartData({required CartDetailsModel newData}) {
    _cartDetailsModel = newData;
  }
}
