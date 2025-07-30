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

  static push(dynamic route) => Navigator.push(context!, route);

  static pushReplacement(dynamic route) =>
      Navigator.pushReplacementNamed(context!, route);
}
