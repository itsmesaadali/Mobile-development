import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EmbeddedCheckout extends StatelessWidget {
  final String clientSecret;

  const EmbeddedCheckout({super.key, required this.clientSecret});

  @override
  Widget build(BuildContext context) {
    final checkoutUrl = "https://checkout.stripe.com/c/pay/$clientSecret";

    return Scaffold(
      appBar: AppBar(title: const Text("Secure Checkout")),
      body: WebViewWidget(
        controller: WebViewController()
          ..loadRequest(Uri.parse(checkoutUrl))
          ..setJavaScriptMode(JavaScriptMode.unrestricted),
      ),
    );
  }
}
