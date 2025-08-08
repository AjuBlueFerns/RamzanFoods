import 'package:crocurry/utils/helper.dart';
import 'package:crocurry/views/screens/checkout/views/checkout_view.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key, required this.url, required this.cartId});
  final String url;
  final String cartId;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  WebViewController? webViewController;
  bool isLoading = true;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      webViewController = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              // Update loading bar.
            },
            onPageStarted: (String url) {},
            onPageFinished: (String url) async {
              // setState(() {});
              Helper.showLog(" ## page finished $url");
              // if(url == "https://crocurry.com/store/docod/"){
              //   Future.delayed(Duration(seconds: ))
              //   Helper.pop();
              // }
              // if (url == "https://crocurry.com/store/cart/payment/success") {
              //   await CommonFunctions.checkOrderStatus(context, widget.cartId,
              //       shouldPop: true);
              // }
              // if (url == "https://crocurry.com/store/cart/show-cart") {
              //   if (context.mounted) {
              //     context.pop();
              //   }
              // }
            },
            onHttpError: (HttpResponseError error) {},
            onWebResourceError: (WebResourceError error) {},
            onNavigationRequest: (NavigationRequest request) {
              if (request.url.startsWith('https://www.youtube.com/')) {
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
          ),
        )
        ..loadRequest(Uri.parse(widget.url)).then((value) => isLoading = false);
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    webViewController!.clearCache();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Stack(
        children: [
          if (webViewController != null)
            CheckoutView(
              webViewController: webViewController!,
              cartId: widget.cartId,
            ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            )
        ],
      ),
    );
  }
}
