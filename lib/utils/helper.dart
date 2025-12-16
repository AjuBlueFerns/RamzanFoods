import 'dart:developer';

import 'package:crocurry/main.dart';
import 'package:flutter/material.dart';

class Helper {
  Helper._();

  static GlobalKey? key = NavigationService.navigatorKey;
  static BuildContext? context = key!.currentContext!;

  static double getWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
  static double getHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static Widget allowHeight(double height) => SizedBox(height: height);
  static Widget allowWidth(double width) => SizedBox(width: width);

  static const Widget shrink = SizedBox.shrink();

  static void showLog(String message) => log(message);

  static Future<Object?> push(dynamic route) => Navigator.push(context!, route);

  static Future<Object?> pushReplacementNamedRoute(dynamic route) =>
      Navigator.pushReplacementNamed(context!, route);

  static Future pushAndRemoveUntilRoute(dynamic route) =>
      Navigator.of(context!).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => route,
          ),
          (Route<dynamic> route) => false);

  static void pop() => Navigator.pop(context!);

  static void showSnack({required String message, Color? bgColor}) =>
      ScaffoldMessenger.of(context!)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.black,
          ),
        );
}
