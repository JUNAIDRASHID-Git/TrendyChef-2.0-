import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:trendychef/core/services/api/banner/get.dart';
import 'package:trendychef/core/services/api/user/get.dart';
import 'package:trendychef/core/services/api/user/order.dart';
import 'package:trendychef/core/services/models/banner/banner.dart';
import 'package:trendychef/core/services/models/order/order.dart';
import 'package:trendychef/core/services/models/user/user.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountInitial()) {
    on<GetUserDetailEvent>((event, emit) async {
      emit(AccountLoading());
      try {
        final user = await getUser();
        final recentOrders = await fetchRecentOrder(user.id);
        final banners = await fetchBanner();
        emit(
          AccountLoaded(
            user: user,
            recentOrders: recentOrders,
            banners: banners,
          ),
        );
      } catch (e) {
        emit(AccountError(error: e.toString()));
      }
    });
  }
}
