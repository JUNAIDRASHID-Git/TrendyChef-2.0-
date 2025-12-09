import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/core/services/models/user/user.dart';
import 'package:trendychef/core/theme/app_colors.dart';
import 'package:trendychef/l10n/app_localizations.dart';
import 'package:trendychef/presentation/account/bloc/account_bloc.dart';
import 'package:trendychef/presentation/address/cubit/address_cubit.dart';
import 'package:trendychef/presentation/address/widget/header/address_header.dart';
import 'package:trendychef/presentation/address/widget/buttons/region_selector.dart';
import 'package:trendychef/presentation/address/widget/text_field/phone_input_field.dart';
import 'package:trendychef/widgets/buttons/RoundedButton/roundedbutton.dart';

class AddressUpdatingScreen extends StatefulWidget {
  const AddressUpdatingScreen({super.key});

  @override
  State<AddressUpdatingScreen> createState() => _AddressUpdatingScreenState();
}

class _AddressUpdatingScreenState extends State<AddressUpdatingScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController postalController = TextEditingController();
  final TextEditingController streetController = TextEditingController();

  String selectedRegion = "";

  @override
  void initState() {
    super.initState();
  }

  void fillUserData(UserModel user) {
    phoneController.text = user.phone;
    cityController.text = user.address.city;
    postalController.text = user.address.postalCode;
    streetController.text = user.address.street;
    selectedRegion = user.address.state; // region
  }

  String? phoneError;

  void validatePhone(String value) {
    if (value.isEmpty) {
      phoneError = "Phone number is required";
    } else if (!value.startsWith('5')) {
      phoneError = "Phone must start with 5";
    } else if (value.length != 9) {
      phoneError = "Phone must be 9 digits";
    } else {
      phoneError = null;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddressCubit, AddressState>(
      listener: (context, state) {
        if (state is AddressLoaded) {
          fillUserData(state.user);
          setState(() {});
        }

        if (state is AddressUpdateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Address updated successfully")),
          );
          Navigator.pop(context);
        }

        if (state is AddressError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final loading = state is AddressLoading;

        return Scaffold(
          backgroundColor: Colors.grey[200],
          body: loading
              ? const Center(child: CircularProgressIndicator())
              : _buildContent(context),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(height: 40, color: AppColors.primary),
          const AddressHeader(),
          const SizedBox(height: 30),

          // PHONE
          TextInputField(
            controller: phoneController,
            label: lang.phonenumber,
            hint: "5XXXXXXXX",
            prefix: "+966",
            isPhone: true,
            error: phoneError,
            onChanged: validatePhone,
          ),

          const SizedBox(height: 10),

          // REGION SELECTOR
          RegionSelector(
            selectedRegion: selectedRegion,
            onRegionSelected: (region) {
              setState(() => selectedRegion = region);
            },
          ),

          const SizedBox(height: 10),

          // CITY
          TextInputField(
            controller: cityController,
            label: lang.city,
            onChanged: (_) {},
          ),

          const SizedBox(height: 10),

          // POSTAL CODE
          TextInputField(
            controller: postalController,
            label: lang.postalcode,
            keyboardType: TextInputType.number,
            isPostal: true,
            onChanged: (_) {},
          ),

          const SizedBox(height: 10),

          // STREET (Expandable)
          TextInputField(
            controller: streetController,
            label: lang.streetaddress,
            expandable: true,
            maxLines: 5,
            onChanged: (_) {},
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: RoundedButton(
                  text: lang.cancel,
                  color: AppColors.backGroundColor,
                  textColor: AppColors.fontGrey,
                  onTap: () => Navigator.pop(context),
                ),
              ),
              Expanded(
                child: RoundedButton(
                  text: lang.save,
                  color: AppColors.primary,
                  onTap: () {
                    context.read<AddressCubit>().updateAddress(
                      phone: phoneController.text,
                      city: cityController.text,
                      postalCode: postalController.text,
                      street: streetController.text,
                      region: selectedRegion,
                    );
                    context.read<AccountBloc>().add(GetUserDetailEvent());
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
