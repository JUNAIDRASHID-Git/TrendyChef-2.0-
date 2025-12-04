import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebViewPage extends StatefulWidget {
  final String paymentUrl;

  const PaymentWebViewPage({required this.paymentUrl, super.key});

  @override
  State<PaymentWebViewPage> createState() => _PaymentWebViewPageState();
}

class _PaymentWebViewPageState extends State<PaymentWebViewPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (navigation) {
            final url = navigation.url;

            // Check if URL contains success, cancel or failed
            if (url.contains("success")) {
              Navigator.pop(context); // Close WebView
              Navigator.pushNamed(
                context,
                '/success',
              ); // Navigate to success page
              return NavigationDecision.prevent; // Stop WebView from loading
            } else if (url.contains("cancel")) {
              Navigator.pop(context);
              Navigator.pushNamed(
                context,
                '/cancel',
              ); // Navigate to cancel page
              return NavigationDecision.prevent;
            } else if (url.contains("failed")) {
              Navigator.pop(context);
              Navigator.pushNamed(
                context,
                '/failed',
              ); // Navigate to failed page
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate; // Continue loading other pages
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: WebViewWidget(controller: _controller),
    );
  }
}
