import 'package:objectbox/objectbox.dart';

@Entity()
class UserModel {
  @Id()
  int id = 0;
  String? firstName;
  String? lastName;
  String? userName;
  String? email;
  String? password;
  String? userType;
  String? registerDate;
  String? activationId;
  String? billingTelephone;
  String? billingAddress;
  String? billingCity;
  String? billingState;
  String? billingZip;
  String? billingCountry;
  String? shippingAddress;
  String? shippingCity;
  String? shippingState;
  String? shippingZip;
  String? shippingCountry;
  String? shippingTelephone;
  UserModel({
    this.activationId,
    this.billingAddress,
    this.billingCity,
    this.billingCountry,
    this.billingState,
    this.billingTelephone,
    this.billingZip,
    this.email,
    this.firstName,
    this.lastName,
    this.password,
    this.registerDate,
    this.shippingAddress,
    this.shippingCity,
    this.shippingCountry,
    this.shippingState,
    this.shippingZip,
    this.shippingTelephone,
    this.userName,
    this.userType,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      activationId: json['activation_id'] ?? "",
      billingAddress: json['billing_addr'] ?? "",
      billingCity: json['billing_city'] ?? "",
      billingCountry: json['billing_country'] ?? "",
      billingState: json['billing_state'] ?? "",
      billingTelephone: json['billing_telephone'] ?? "",
      billingZip: json['billing_zip'] ?? "",
      email: json['email'] ?? "",
      firstName: json['first_name'] ?? "",
      lastName: json['last_name'] ?? "",
      userName: json['user_name'] ?? "",
      password: json['password'] ?? "",
      shippingAddress: json['shipping_addr'] ?? "",
      shippingCity: json['shipping_city'] ?? "",
      shippingCountry: json['shipping_country'] ?? "",
      shippingState: json['shipping_state'] ?? "",
      shippingTelephone: json['shipping_telephone'] ?? "",
      shippingZip: json['shipping_zip'] ?? "",
      userType: json['user_type'] ?? "",
      registerDate: json['register_date'] ?? "",
    );
  }
}
