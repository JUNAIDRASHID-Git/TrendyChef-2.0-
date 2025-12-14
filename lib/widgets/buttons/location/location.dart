import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trendychef/core/services/models/user/user.dart';
import 'package:trendychef/core/theme/app_colors.dart';
import 'package:trendychef/presentation/address/address.dart';
import 'package:trendychef/presentation/address/cubit/address_cubit.dart';

class LocationButton extends StatelessWidget {
  const LocationButton({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final address = user.address;

    // Build full formatted address from non-empty fields
    final List<String> addressParts = [
      address.street,
      address.city,
      address.state, // region
      address.postalCode,
      address.country,
    ].where((item) => item.trim().isNotEmpty).toList();

    final bool hasAddress = addressParts.isNotEmpty;
    final String fullAddress = addressParts.join(", ");

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Material(
        color: AppColors.backGroundColor,
        borderRadius: BorderRadius.circular(19),
        child: InkWell(
          borderRadius: BorderRadius.circular(19),
          splashColor: AppColors.fontGrey.withOpacity(0.2),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => AddressCubit()..loadUser(),
                  child: AddressUpdatingScreen(),
                ),
              ),
            );
          },
          child: Ink(
            height: 80,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(19)),
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/location-pin.svg",
                      height: 30,
                      color: AppColors.fontColor,
                    ),
                    const SizedBox(width: 10),

                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: Text(
                        hasAddress ? fullAddress : "Add Location",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                SvgPicture.asset(
                  hasAddress
                      ? "assets/icons/edit.svg"
                      : "assets/icons/add-circle.svg",
                  height: 25,
                  color: AppColors.fontColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
