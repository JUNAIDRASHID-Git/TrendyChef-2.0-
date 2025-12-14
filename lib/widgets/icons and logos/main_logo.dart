import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainLogo extends StatelessWidget {
  final double height;
  const MainLogo({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset("assets/images/trendy_logo1.svg", height: height);
  }
}
