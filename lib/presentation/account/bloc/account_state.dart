part of 'account_bloc.dart';

@immutable
sealed class AccountState {}

final class AccountInitial extends AccountState {}

final class AccountLoading extends AccountState {}

final class AccountLoaded extends AccountState {
  final UserModel user;

  AccountLoaded({required this.user});
}

final class AccountError extends AccountState {}
