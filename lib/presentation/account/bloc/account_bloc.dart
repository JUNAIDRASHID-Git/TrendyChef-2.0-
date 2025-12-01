import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:trendychef/core/services/api/user/get.dart';
import 'package:trendychef/core/services/models/user/user.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountInitial()) {
    on<GetUserDetailEvent>((event, emit) async {
      emit(AccountLoading());
      try {
        final user = await getUser();
        emit(AccountLoaded(user: user));
      } catch (e) {
        emit(AccountError());
      }
    });
  }
}
