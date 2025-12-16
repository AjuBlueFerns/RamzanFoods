import 'package:crocurry/domain/use_cases/cart/check_order_status.dart';
import 'package:crocurry/utils/locator.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key, required this.webViewController, required this.cartId});
  final WebViewController webViewController;
  final String cartId;
  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  @override
  void dispose() {
    checkStatus();
    super.dispose();
  }

  Future<void> checkStatus() async {
    var response = await locator<CheckOrderStatus>().call(widget.cartId);
    if (response.$1 != null) {
      debugPrint("### response ${response.$1!}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: widget.webViewController);
  }
}
