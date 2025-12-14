// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:flutter/material.dart';

class PaymentPageWeb extends StatefulWidget {
  final String paymentUrl;

  const PaymentPageWeb({required this.paymentUrl, super.key});

  @override
  State<PaymentPageWeb> createState() => _PaymentPageWebState();
}

class _PaymentPageWebState extends State<PaymentPageWeb> {
  @override
  void initState() {
    super.initState();
    html.window.location.href = widget.paymentUrl;
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Redirecting to payment...\nPlease wait',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
