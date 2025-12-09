import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trendychef/core/services/models/user/user.dart';
import 'package:trendychef/core/theme/app_colors.dart';
import 'package:trendychef/l10n/app_localizations.dart';
import 'package:trendychef/presentation/account/bloc/account_bloc.dart';
import 'package:trendychef/presentation/cart/cubit/cart_cubit.dart';

class AccountHeader extends StatelessWidget {
  const AccountHeader({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
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
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 50,
                        width: 50,
                        color: Colors.grey.shade200,
                        child: const Icon(
                          Icons.person,
                          size: 30,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
              if (!isGuest) SizedBox(width: 20),
              Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    "${lang.hala} ${user.name}",
                    style: TextStyle(
                      color: AppColors.fontColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: "inter",
                      fontSize: 18,
                    ),
                  ),
                  if (isGuest)
                    Text(
                      lang.logintotrendycheftoviewandmanageyouraccount,
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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.red,
                    foregroundColor: AppColors.backGroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final userToken = prefs.getString("idtoken");

                    if (userToken != null) {
                      prefs.remove("idtoken");
                    }
                    context.read<CartCubit>().loadCart();
                    context.read<AccountBloc>().add(GetUserDetailEvent());
                  },
                  child: Text(lang.logout),
                ),
            ],
          ),
          if (isGuest) SizedBox(height: 15),
          if (isGuest)
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: () => context.push('/auth'),
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
                        lang.login,
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
