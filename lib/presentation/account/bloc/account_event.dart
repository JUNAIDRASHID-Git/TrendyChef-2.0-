part of 'account_bloc.dart';

@immutable
sealed class AccountEvent {}

final class GetUserDetailEvent extends AccountEvent {}
