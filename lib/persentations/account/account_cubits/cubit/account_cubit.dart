import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:terator/models/account_model.dart';
import 'package:terator/repositories/account_repository.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(const AccountState());

  final AccountRepository _accountRepo = AccountRepository();
  final int _limit = 10;

  List<AccountModel> _data = [];

  int _page = 1;
  bool hasReachMax = false;

  Future<void> getAccounts({bool isInit = false}) async {
    if (isInit) {
      emit(const AccountState(status: AccountStatusCubit.loading));
      _page = 1;
      List<AccountModel> response =
          await _accountRepo.all(page: _page, limit: _limit);
      _data = response;
      hasReachMax = _data.length < _limit ? true : false;
      return emit(AccountState(
          status: AccountStatusCubit.success,
          hasReachMax: hasReachMax,
          accounts: _data));
    } else {
      _page++;
      List<AccountModel> response =
          await _accountRepo.all(page: _page, limit: _limit);
      _data.addAll(response);
      hasReachMax = (response).length < _limit ? true : false;
      return emit(AccountState(
          status: AccountStatusCubit.success,
          hasReachMax: hasReachMax,
          accounts: _data));
    }
  }
}
