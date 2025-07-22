
import 'package:crocurry/data/models/user_model.dart';
import 'package:crocurry/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDatasource {
  Future updateUserdetails(UserModel user);
}

class UserRemotedataSourceImpl extends UserRemoteDatasource {
  @override
  Future updateUserdetails(UserModel user) async {
    var url = baseUrl + mobileAppEndpoint;
    var params = {
      "key": 'update-user',
    };
    // if (user.firstName != null && user.firstName!.isNotEmpty) {
    params.addAll({"first_name": user.firstName ?? ""});
    // }
    // if (user.lastName != null && user.lastName!.isNotEmpty) {
    params.addAll({"last_name": user.lastName ?? " "});
    // }
    // if (user.userName != null && user.userName!.isNotEmpty) {
    params.addAll({"user_name": user.userName ?? ""});
    // }
    params.addAll({"email": user.email ?? ""});


    // if (user.billingAddress != null && user.billingAddress!.isNotEmpty) {
    params.addAll({"billing_addr": user.billingAddress ?? ""});
    // }
    // if (user.billingCity != null && user.billingCity!.isNotEmpty) {
    params.addAll({"billing_city": user.billingCity ?? ""});
    // }
    // if (user.billingState != null && user.billingState!.isNotEmpty) {
    params.addAll({"billing_state": user.billingState ?? ""});
    // }
    // if (user.billingCountry != null && user.billingCountry!.isNotEmpty) {
    params.addAll({"billing_country": user.billingCountry ?? ""});
    // }
    // if (user.billingZip != null && user.billingZip!.isNotEmpty) {
    params.addAll({"billing_zip": user.billingZip ?? ""});
    // }
    // if (user.billingTelephone != null && user.billingTelephone!.isNotEmpty) {
    params.addAll({"billing_telephone": user.userName ?? ""});
    // }
    // if (user.shippingAddress != null && user.shippingAddress!.isNotEmpty) {
    params.addAll({"shipping_addr": user.shippingAddress ?? ""});
    // }/
    // if (user.shippingCity != null && user.shippingCity!.isNotEmpty) {
    params.addAll({"shipping_city": user.shippingCity ?? ""});
    // }
    // if (user.shippingState != null && user.shippingState!.isNotEmpty) {
    params.addAll({"shipping_state": user.shippingState ?? ""});
    // }
    // if (user.shippingCountry != null && user.shippingCountry!.isNotEmpty) {
    params.addAll({"shipping_country": user.shippingCountry ?? ""});
    // }/
    // if (user.shippingZip != null && user.shippingZip!.isNotEmpty) {
    params.addAll({"shipping_zip": user.shippingZip ?? ""});
    // }
    // if (user.shippingTelephone != null && user.shippingTelephone!.isNotEmpty) {
    params.addAll({"shipping_telephone": user.shippingTelephone ?? ""});
    // }
    params.addAll({"token": ""});
    params.addAll({"rand": ""});
    // if (user.activationId != null && user.activationId!.isNotEmpty) {
    debugPrint("activation_id  : ${user.activationId}");

    params.addAll({"act_id": user.activationId ?? " "});
    // }

    var uri = Uri.parse(url).replace(queryParameters: params);
    debugPrint("updateUserdetails url : ${uri.toString()}");

    var response = await http.get(uri);
    if (response.statusCode == 200) {
      debugPrint("## response : ${response.body}.");

    } else {
      return (null, Exception(''));
    }
  }
}
