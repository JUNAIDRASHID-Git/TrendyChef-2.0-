import 'package:flutter/material.dart';
import 'package:trendychef/core/services/models/user/user.dart';
import 'package:trendychef/presentation/account/widget/footer/footer.dart';
import 'package:trendychef/presentation/account/widget/header/header.dart';
import 'package:trendychef/widgets/container/carousel/auto_crousel_slider.dart';

class GuestAccountScreenView extends StatelessWidget {
  const GuestAccountScreenView({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.89,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AccountHeader(user: user),
            AutoSlidingBanner(),
            SizedBox(height: 20),
            AccountFooter(),
          ],
        ),
      ),
    );
  }
}
