import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trendychef/core/theme/app_colors.dart';
import 'package:trendychef/presentation/account/bloc/account_bloc.dart';
import 'package:trendychef/presentation/account/widget/guest_view/guest_view.dart';
import 'package:trendychef/presentation/account/widget/header/header.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: BlocBuilder<AccountBloc, AccountState>(
          builder: (context, state) {
            if (state is AccountLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is AccountLoaded) {
              final user = state.user;
              if (user.name == "user") {
                return GuestAccountScreenView(user: user);
              }
              return Column(
                children: [
                  AccountHeader(user: user),
                  Container(
                    height: 80,
                    padding: EdgeInsets.all(14),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.backGroundColor,
                      borderRadius: BorderRadius.circular(19),
                    ),
                    child: Row(
                      mainAxisAlignment: .spaceBetween,
                      crossAxisAlignment: .center,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/images/location-pin.svg",
                              height: 25,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Add Location",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        SvgPicture.asset(
                          height: 35,
                          color: AppColors.fontColor,
                          "assets/images/add-circle.svg",
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: AppColors.backGroundColor,
                        borderRadius: BorderRadius.circular(19),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              "Recent Order",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          SizedBox(height: 5),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(19),
                              ),
                              child: Container(
                                padding: EdgeInsets.all(14),
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColors.backGroundColor,
                                  borderRadius: BorderRadius.circular(19),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          "assets/images/order.svg",
                                          height: 70,
                                        ),
                                        Text(
                                          "No Order found",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          "Place an order to easily\nmanage your purchases",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: AppColors.fontGrey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
