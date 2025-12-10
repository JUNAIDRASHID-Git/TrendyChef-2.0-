part of 'account_bloc.dart';

@immutable
sealed class AccountState {}

final class AccountInitial extends AccountState {}

final class AccountLoading extends AccountState {}

final class AccountLoaded extends AccountState {
  final UserModel user;
  final List<OrderModel> recentOrders;

  AccountLoaded({required this.user, required this.recentOrders});
}

final class AccountError extends AccountState {
  final String error;

  AccountError({required this.error});
}
