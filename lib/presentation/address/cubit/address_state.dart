part of 'address_cubit.dart';

abstract class AddressState {}

class AddressInitial extends AddressState {}

class AddressLoading extends AddressState {}

class AddressLoaded extends AddressState {
  final UserModel user;
  AddressLoaded(this.user);
}

class AddressUpdating extends AddressState {}

class AddressUpdateSuccess extends AddressState {}

class AddressError extends AddressState {
  final String message;
  AddressError(this.message);
}
