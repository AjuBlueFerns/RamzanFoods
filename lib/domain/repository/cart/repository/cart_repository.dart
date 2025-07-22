import 'package:crocurry/data/models/cart_details_model.dart';
import 'package:crocurry/data/models/cart_model.dart';

abstract class CartRepository {
  Future<(CartModel?, Exception?)> addToCart(int qty, String productId);
  Future removeFromCart(String productId, String cartItemNumber);
  Future<(CartDetailsModel?, Exception?)> viewCart();
  Future updateQtyInCart(
    String cartId,
    String productId,
    String cartItemNumber,
    int newQty,
  );
  Future<String> getCartId();
  Future<(bool?, Exception?)> checkOrderStatus(String cartId);
  Future<void> clearCartId();
  // Future<void> addCartItem(CartDetailsItemModel cartItem);
  // Future<List<CartDetailsItemModel>> getCartItems();
}
