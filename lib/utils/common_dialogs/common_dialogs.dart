import 'dart:io';

import 'package:crocurry/utils/common_dialogs/filters_bottom_sheet.dart';
import 'package:crocurry/utils/common_dialogs/login_mobile_num_dialog.dart';
import 'package:crocurry/utils/common_dialogs/otp_dialog.dart';
import 'package:crocurry/utils/constants.dart';
import 'package:crocurry/utils/extensions/context_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonDialogs {
  static Future showConfirmDialog({
    required BuildContext context,
    String title = "Confirm",
    String positiveButtonText = "Yes",
    String negativeButtonText = 'No',
    required String description,
    required VoidCallback callBack,
  }) async {
    if (Platform.isIOS) {
      await showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(description),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () {
                  context.pop();
                },
                child: Text(negativeButtonText),
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                onPressed: () {
                  callBack.call();
                },
                child: Text(positiveButtonText),
              )
            ],
          );
        },
      );
    } else {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(description),
            actions: [
              TextButton(
                onPressed: () {
                  context.pop();
                },
                child: Text(negativeButtonText),
              ),
              const SizedBox(width: defaultPadding),
              TextButton(
                onPressed: () {
                  callBack.call();
                },
                child: Text(positiveButtonText),
              )
            ],
          );
        },
      );
    }
  }

  static Future showAlertDialog({
    required BuildContext context,
    String title = "Alert",
    String positiveButtonText = "OK",
    // String negativeButtonText = 'No',
    required String description,
    required VoidCallback callBack,
  }) async {
    if (Platform.isIOS) {
      await showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(description),
            actions: [
              CupertinoDialogAction(
                isDestructiveAction: true,
                onPressed: () {
                  context.pop();
                },
                child: Text(positiveButtonText),
              ),
            ],
          );
        },
      );
    } else {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(description),
            actions: [
              TextButton(
                onPressed: () {
                  callBack.call();
                },
                child: Text(positiveButtonText),
              )
            ],
          );
        },
      );
    }
  }

  static Future showFiltersBottomSheet({required BuildContext context}) async {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return const FiltersBottomSheet();
      },
    );
  }

  static Future showLoginMobileNumberDialog({
    required BuildContext context,
    String title = "Login / Sign Up",
    VoidCallback? callback,
  }) async {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return LoginMobileNumDialog(
          title: title,
          callback: callback,
        );
      },
    );
  }

  static Future showOtpDialog({
    required BuildContext context,
    required String mobile,
    required String hash,
    VoidCallback? callback,
  }) async {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return OtpDialog(
            mobile: mobile,
            hash: hash,
            callback: callback,
          );
        });
      },
    );
  }
}
