import 'package:flutter/material.dart';
import 'package:trendychef/core/services/models/user/user.dart';
import 'package:trendychef/core/theme/app_colors.dart';
import 'package:trendychef/widgets/buttons/RoundedButton/roundedbutton.dart';

class AccountHeader extends StatelessWidget {
  const AccountHeader({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final bool isGuest = user.name == "user";
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.all(14),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.backGroundColor,
        borderRadius: BorderRadius.circular(19),
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Row(
            children: [
              if (!isGuest)
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    user.picture ?? "",
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              if (!isGuest) SizedBox(width: 20),
              Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    "Hala ${user.name}",
                    style: TextStyle(
                      color: AppColors.fontColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: "inter",
                      fontSize: 18,
                    ),
                  ),
                  if (isGuest)
                    Text(
                      "Log in to TrendyChef to view and manage your account",
                      style: TextStyle(
                        color: AppColors.fontColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: "inter",
                        fontSize: 14,
                      ),
                    ),
                  if (!isGuest)
                    Text(
                      user.email ?? "",
                      style: TextStyle(
                        color: AppColors.fontGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: "inter",
                        fontSize: 14,
                      ),
                    ),
                ],
              ),
              if (!isGuest) SizedBox(width: 10),
              if (!isGuest)
                SizedBox(
                  height: 50,
                  width: 100,
                  child: RoundedButton(
                    text: "Log Out",
                    onTap: () {},
                    color: AppColors.red,
                  ),
                ),
            ],
          ),
          if (isGuest) SizedBox(height: 15),
          if (isGuest)
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: () {
                  Navigator.pushNamed(context, "/auth");
                },
                splashColor: AppColors.backGroundColor.withOpacity(0.2),
                highlightColor: Colors.transparent,
                child: Ink(
                  height: 50,
                  width: 160,
                  decoration: BoxDecoration(
                    color: AppColors.blue,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.account_circle_rounded,
                        color: AppColors.backGroundColor,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Login in",
                        style: TextStyle(
                          color: AppColors.backGroundColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: "inter",
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
