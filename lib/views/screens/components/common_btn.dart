import 'package:crocurry/domain/use_cases/connectivity/check_connectivity_repo.dart';
import 'package:crocurry/utils/custom_toast.dart';
import 'package:crocurry/utils/locator.dart';
import 'package:flutter/material.dart';

class CommonBtn extends StatelessWidget {
  const CommonBtn({
    super.key,
    required this.onPressed,
    this.title,
    required this.child,
    this.style,
  });
  final VoidCallback onPressed;
  final String? title;
  final Widget child;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        var isConnected = await locator<CheckConnectivity>().call();
        if (isConnected) {
          onPressed.call();
        } else {
          if (context.mounted) {
            CustomToast.showInfoMessage(
                context: context, message: 'No Connection! Please try again');
          }
        }
      },
      style: style,
      child: child,
      // child: Text(title),
    );
  }
}
