import 'package:objectbox/objectbox.dart';

@Entity()
class CartIdModel {
  @Id()
  int id = 0;
  String? cartId;
  String? userId;
  int? cartCount = 0;

  CartIdModel(
    this.cartId,
    this.userId,
  );
}
