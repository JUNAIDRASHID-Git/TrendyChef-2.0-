import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/core/services/api/user/get.dart';
import 'package:trendychef/core/services/api/user/put.dart';
import 'package:trendychef/core/services/models/user/user.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(AddressInitial());

  UserModel? _user;

  UserModel? get user => _user;

  /// Fetch user from API (getUser)
  Future<void> loadUser() async {
    emit(AddressLoading());

    try {
      final fetchedUser = await getUser();
      _user = fetchedUser;

      emit(AddressLoaded(fetchedUser));
    } catch (e) {
      emit(AddressError("Failed to load user"));
    }
  }

  /// Update user with new address + phone
  Future<void> updateAddress({
    required String phone,
    required String city,
    required String postalCode,
    required String street,
    required String region,
  }) async {
    if (phone.isEmpty ||
        city.isEmpty ||
        postalCode.isEmpty ||
        street.isEmpty ||
        region.isEmpty) {
      emit(AddressError("All fields are required"));
      return;
    }

    emit(AddressUpdating());

    final updatedUser = UserModel(
      id: _user!.id,
      name: _user!.name,
      phone: phone,
      email: _user!.email,
      picture: _user!.picture,
      provider: _user!.provider,
      address: Address(
        street: street,
        city: city,
        state: region, // region stored as state
        postalCode: postalCode,
        country: "KSA",
      ),
    );

    final success = await updateUser(updatedUser);

    if (success) {
      _user = updatedUser;
      emit(AddressUpdateSuccess());
    } else {
      emit(AddressError("Failed to update address"));
    }
  }
}
