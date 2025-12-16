import 'package:crocurry/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomToast {
  static Future showErrorMessage({
    required BuildContext context,
    required String message,
    SnackBarAction? action,
  }) async {
    showDefaultToast(
        context: context,
        message: message,
        action: action,
        icon: Icons.error_outline_outlined);
    // toastification.show(
    //   context: context,
    //   title: Text(message),
    //   type: ToastificationType.error,
    //   style: ToastificationStyle.minimal,
    //   autoCloseDuration: const Duration(seconds: 1),
    // );
  }

  static Future showSuccessMessage({
    required BuildContext context,
    required String message,
    bool showAction = false,
    SnackBarAction? action,
  }) async {
    showDefaultToast(context: context, message: message, action: action, icon: Icons.check_circle_outline_outlined,);
    // toastification.show(
    //   alignment: Alignment.bottomCenter,
    //   showProgressBar: false,
    //   context: context,
    //   title: Text(message),
    //   type: ToastificationType.success,
    //   style: ToastificationStyle.minimal,
    //   autoCloseDuration: const Duration(seconds: 2),
    // );
  }

  static Future showInfoMessage({
    required BuildContext context,
    required String message,
    SnackBarAction? action,
  }) async {
    showDefaultToast(
      context: context,
      message: message,
      action: action,
      icon: Icons.info_outline_rounded,
    );
    // toastification.show(
    //   alignment: Alignment.bottomCenter,
    //   showProgressBar: false,
    //   context: context,
    //   title: Text(message),
    //   type: ToastificationType.info,
    //   style: ToastificationStyle.minimal,
    //   autoCloseDuration: const Duration(seconds: 2),
    // );
  }

  static void showDefaultToast({
    required BuildContext context,
    required String message,
    SnackBarAction? action,
    IconData? icon,
    Color? iconColor,
  }) {
    var snackBar = SnackBar(
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating ,
      content: Row(
        children: [
          if (icon != null)
            Icon(
              icon,
              color: iconColor ?? whiteColor,
            ),
          const SizedBox(width: defaultPadding),
          Text(message, style: const TextStyle(color: whiteColor),),
        ],
      ),
      action: action,
      margin: const EdgeInsets.all(defaultPadding),
    );
    // ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
