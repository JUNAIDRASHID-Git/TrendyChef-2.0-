import 'package:flutter/material.dart';
import 'package:trendychef/core/theme/app_colors.dart';
import 'package:trendychef/widgets/buttons/socila_media/socila_media.dart';
import 'package:trendychef/widgets/buttons/text/text.dart';

class AccountFooter extends StatelessWidget {
  const AccountFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(color: AppColors.backGroundColor),
      child: Column(
        crossAxisAlignment: .center,
        mainAxisAlignment: .center,
        children: [
          SizedBox(height: 10),
          Text(
            "Follow New Trends With Us",
            style: TextStyle(
              color: AppColors.bluefont,
              fontWeight: FontWeight.bold,
              fontFamily: "inter",
              fontSize: 14,
            ),
          ),
          Divider(
            endIndent: 0.5,
            height: 30,
            color: AppColors.fontColor.withOpacity(0.05),
          ),
          SizedBox(),

          Row(
            mainAxisAlignment: .center,
            children: [
              SocilaMediaButton(
                iconSvgPath: "assets/images/whatsapp-svgrepo-com.svg",
                onTap: () {},
              ),
              SocilaMediaButton(
                iconSvgPath: "assets/images/tictok-svgrepo-com.svg",
                onTap: () {},
              ),
              SocilaMediaButton(
                iconSvgPath: "assets/images/instagram-svgrepo-com.svg",
                onTap: () {},
              ),
            ],
          ),

          Row(
            mainAxisAlignment: .spaceEvenly,
            children: [
              TextButtonWidget(
                route: "/terms-and-conditions",
                title: "Terms & Conditions",
                color: AppColors.fontColor.withOpacity(0.5),
              ),

              TextButtonWidget(
                route: "/privacy-policy",
                title: "Privacy Policy",
                color: AppColors.fontColor.withOpacity(0.5),
              ),

              TextButtonWidget(
                route: "/return-policy",
                title: "Return Policy",
                color: AppColors.fontColor.withOpacity(0.5),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
