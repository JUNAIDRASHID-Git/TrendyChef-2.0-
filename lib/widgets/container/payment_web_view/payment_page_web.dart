// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaymentPageWeb extends StatefulWidget {
  final String url;

  const PaymentPageWeb({required this.url, super.key});

  @override
  State<PaymentPageWeb> createState() => _PaymentPageWebState();
}

class _PaymentPageWebState extends State<PaymentPageWeb> {
  @override
  void initState() {
    super.initState();

    // Open payment page in new browser tab
    html.window.open(widget.url, "_blank");

    // Listen for messages from the payment gateway
    html.window.onMessage.listen((event) {
      final data = event.data.toString().toLowerCase();

      if (data.contains("success")) {
        context.go("/payment/success");
      } else if (data.contains("cancel")) {
        context.go("/payment/cancelled");
      } else if (data.contains("failed")) {
        context.go("/payment/failed");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment")),
      body: const Center(
        child: Text(
          "Payment page opened in a new tab...\nPlease complete payment.",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
