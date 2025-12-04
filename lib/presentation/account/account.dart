import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trendychef/core/theme/app_colors.dart';
import 'package:trendychef/presentation/account/bloc/account_bloc.dart';
import 'package:trendychef/presentation/account/widget/footer/footer.dart';
import 'package:trendychef/presentation/account/widget/guest_view/guest_view.dart';
import 'package:trendychef/presentation/account/widget/header/header.dart';
import 'package:trendychef/widgets/buttons/location/location.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sh = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SingleChildScrollView(
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
                    SizedBox(height: 10),
                    LocationButton(user: user),
                    SizedBox(height: 10),
                    Container(
                      height: sh * 0.64,
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
                    SizedBox(height: 10),
                    AccountFooter(),
                  ],
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
