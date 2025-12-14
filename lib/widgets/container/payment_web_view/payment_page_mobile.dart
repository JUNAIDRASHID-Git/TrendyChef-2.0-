import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentPageMobile extends StatefulWidget {
  final String paymentUrl;

  const PaymentPageMobile({required this.paymentUrl, super.key});

  @override
  State<PaymentPageMobile> createState() => _PaymentPageMobileState();
}

class _PaymentPageMobileState extends State<PaymentPageMobile> {
  WebViewController? _controller;

  @override
  void initState() {
    super.initState();

    _setupMobileWebView();
  }

  void _setupMobileWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(onNavigationRequest: _handleNavigation),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  Future<NavigationDecision> _handleNavigation(
    NavigationRequest request,
  ) async {
    final url = request.url.toLowerCase();

    if (url.contains("success")) {
      context.go("/payment/success");
      return NavigationDecision.prevent;
    }

    if (url.contains("cancel")) {
      context.go("/payment/cancelled");
      return NavigationDecision.prevent;
    }

    if (url.contains("failed")) {
      context.go("/payment/failed");
      return NavigationDecision.prevent;
    }

    return NavigationDecision.navigate;
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) return const SizedBox();

    return Scaffold(
      body: SafeArea(
        child: _controller == null
            ? const Center(child: CircularProgressIndicator())
            : WebViewWidget(controller: _controller!),
      ),
    );
  }
}
