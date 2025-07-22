import 'dart:convert';

import 'package:crocurry/data/models/user_model.dart';
import 'package:crocurry/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// class for auth functions from api
abstract class AuthRemoteDatasource {
  /// to send otp to passed mobile
  Future<(String?, Exception?)> getOtp(String mobile);

  /// to verify otp using the otp and hash from getotp
  /// returns user details
  Future<(UserModel?, Exception?)> verifyOtp(
      String mobile, String otp, String hashKey);
}

class AuthRemoteDatasourceImpl extends AuthRemoteDatasource {
  @override
  Future<(String?, Exception?)> getOtp(String mobile) async {
    var url = baseUrl + mobileAppEndpoint;
    var params = {
      "key": 'get-login-otp',
      "otp_for": mobile,
    };
    var uri = Uri.parse(url).replace(queryParameters: params);
    debugPrint("getOtp url : $uri");
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      debugPrint("getOtp resp :${response.body}");
      return (response.body, null);
    } else {
      return (null, Exception(''));
    }
  }

  @override
  Future<(UserModel?, Exception?)> verifyOtp(
      String mobile, String otp, String hashKey) async {
    var url = baseUrl + otpEndPoint;
    var params = {
      "userId": mobile,
      "pswd": otp,
      's': hashKey,
    };
    var uri = Uri.parse(url).replace(queryParameters: params);
    debugPrint("verifyOtp url : $uri");
    var response = await http.get(uri);
    var result = jsonDecode(response.body);
    if (response.statusCode == 200 && result != -1) {
      debugPrint("verifyOtp resp :${response.body}");
      return (UserModel.fromJson(jsonDecode(response.body)), null);
    } else {
      return (null, Exception(result));
    }
  }
}
