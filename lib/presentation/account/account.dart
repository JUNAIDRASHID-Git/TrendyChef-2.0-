import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/presentation/account/bloc/account_bloc.dart';
import 'package:trendychef/presentation/account/widget/footer/footer.dart';
import 'package:trendychef/presentation/account/widget/guest_view/guest_view.dart';
import 'package:trendychef/presentation/account/widget/header/header.dart';
import 'package:trendychef/presentation/account/widget/order_widget/order_widget.dart';
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
                    SizedBox(height: 10),
                    AccountHeader(user: user),
                    SizedBox(height: 10),
                    LocationButton(user: user),
                    SizedBox(height: 10),
                    RecentOrderWidget(sh: sh, state: state),
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
