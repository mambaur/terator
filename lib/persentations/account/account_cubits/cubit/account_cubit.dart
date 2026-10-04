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
  int _total = 0;

  // Active search from the Akun Surat search bar; kept so pagination and
  // refreshes stay within it.
  String _query = '';

  /// Sets the search text and reloads.
  Future<void> applyFilter({String query = ''}) {
    _query = query;
    return getAccounts(isInit: true);
  }

  Future<void> getAccounts({bool isInit = false}) async {
    if (isInit) {
      emit(AccountState(status: AccountStatusCubit.loading, total: _total));
      _page = 1;
      _total = await _accountRepo.count();
      List<AccountModel> response =
          await _accountRepo.all(page: _page, limit: _limit, query: _query);
      _data = response;
      hasReachMax = _data.length < _limit ? true : false;
      return emit(AccountState(
          status: AccountStatusCubit.success,
          hasReachMax: hasReachMax,
          total: _total,
          accounts: _data));
    } else {
      _page++;
      List<AccountModel> response =
          await _accountRepo.all(page: _page, limit: _limit, query: _query);
      _data.addAll(response);
      hasReachMax = (response).length < _limit ? true : false;
      return emit(AccountState(
          status: AccountStatusCubit.success,
          hasReachMax: hasReachMax,
          total: _total,
          accounts: _data));
    }
  }
}
