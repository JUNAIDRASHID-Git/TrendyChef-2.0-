import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/core/services/api/cart/get.dart';
import 'package:trendychef/core/services/api/user/order.dart';
import 'package:trendychef/presentation/account/bloc/account_bloc.dart';
import 'package:trendychef/presentation/cart/cubit/cart_cubit.dart';
import 'package:trendychef/widgets/container/paymentstatus/payment_cancelled.dart';
import 'package:trendychef/widgets/container/paymentstatus/payment_faild.dart';
import 'package:trendychef/widgets/container/paymentstatus/payment_success.dart';
import 'package:webview_flutter/webview_flutter.dart'; // Mobile ONLY
// ignore: avoid_web_libraries_in_flutter
// import 'dart:html' as html;

class PaymentWebViewPage extends StatefulWidget {
  final String paymentUrl;

  const PaymentWebViewPage({required this.paymentUrl, super.key});

  @override
  State<PaymentWebViewPage> createState() => _PaymentWebViewPageState();
}

class _PaymentWebViewPageState extends State<PaymentWebViewPage> {
  WebViewController? _controller;

  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      // _openInBrowserWeb();
    } else {
      _initMobileWebView();
    }
  }

  // ---------------------
  // WEB LOGIC
  // ---------------------
  // void _openInBrowserWeb() {
  //   html.window.open(widget.paymentUrl, "_blank");

  //   // redirect handling
  //   html.window.onMessage.listen((event) {
  //     final data = event.data.toString().toLowerCase();

  //     if (data.contains("success")) {
  //       _handlePaymentSuccess();
  //     } else if (data.contains("cancel")) {
  //       _navigateToPage(const PaymentCancelledPage());
  //     } else if (data.contains("failed")) {
  //       _navigateToPage(const PaymentFailedPage());
  //     }
  //   });
  // }

  // ---------------------
  // MOBILE WEBVIEW LOGIC
  // ---------------------
  void _initMobileWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (nav) => _handleNavigationMobile(nav),
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  Future<NavigationDecision> _handleNavigationMobile(
      NavigationRequest navigation) async {
    final url = navigation.url.toLowerCase();

    if (url.contains("success")) {
      await _handlePaymentSuccess();
      return NavigationDecision.prevent;
    } else if (url.contains("cancel")) {
      _navigateToPage(const PaymentCancelledPage());
      return NavigationDecision.prevent;
    } else if (url.contains("failed")) {
      _navigateToPage(const PaymentFailedPage());
      return NavigationDecision.prevent;
    }

    return NavigationDecision.navigate;
  }

  // ---------------------
  // PAYMENT SUCCESS LOGIC
  // ---------------------
  Future<void> _handlePaymentSuccess() async {
    try {
      final cartItems = await getCartItems();
      if (cartItems.isNotEmpty) {
        await placeOrder(cartItems[0].cartId.toString(), "success");
      }

      await context.read<CartCubit>().loadCart();
      context.read<AccountBloc>().add(GetUserDetailEvent());

      _navigateToPage(const PaymentSuccessPage());
    } catch (e) {
      _navigateToPage(const PaymentFailedPage());
    }
  }

  void _navigateToPage(Widget page) {
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Web → no WebView
    if (kIsWeb) {
      return Scaffold(
        appBar: AppBar(title: const Text("Payment")),
        body: const Center(
          child: Text("Payment opened in new browser tab..."),
        ),
      );
    }

    // Mobile → show WebView
    return Scaffold(
      appBar: AppBar(title: const Text("Payment")),
      body: WebViewWidget(controller: _controller!),
    );
  }
}
