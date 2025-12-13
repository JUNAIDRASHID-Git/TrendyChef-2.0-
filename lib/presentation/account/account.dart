import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/presentation/account/bloc/account_bloc.dart';
import 'package:trendychef/presentation/account/widget/footer/footer.dart';
import 'package:trendychef/presentation/account/widget/guest_view/guest_view.dart';
import 'package:trendychef/presentation/account/widget/header/header.dart';
import 'package:trendychef/presentation/account/widget/order_widget/order_widget.dart';
import 'package:trendychef/widgets/buttons/location/location.dart';
import 'package:trendychef/widgets/container/error/error_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: BlocBuilder<AccountBloc, AccountState>(
          builder: (context, state) {
            if (state is AccountLoading) {
              return SizedBox(
                height: sh,
                child: const Center(child: CircularProgressIndicator()),
              );
            }

            if (state is AccountError) {
              return SizedBox(
                height: sh,
                child: ErrorScreen(error: "Server error"),
              );
            }

            if (state is AccountLoaded) {
              final user = state.user;

              if (user.name == "user") {
                return GuestAccountScreenView(
                  user: user,
                  banners: state.banners,
                );
              }

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 10),
                    AccountHeader(user: user),
                    const SizedBox(height: 10),
                    LocationButton(user: user),
                    const SizedBox(height: 10),
                    RecentOrderWidget(sh: sh, state: state),
                    const SizedBox(height: 10),
                    const AccountFooter(),
                  ],
                ),
              );
            }

            // Fallback in case state is unknown
            return SizedBox(
              height: sh,
              child: const Center(child: Text("Something went wrong")),
            );
          },
        ),
      ),
    );
  }
}
