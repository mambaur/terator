part of 'account_cubit.dart';

enum AccountStatusCubit { loading, success, failure }

@immutable
class AccountState {
  final AccountStatusCubit? status;
  final List<AccountModel>? accounts;
  final String? message;
  final bool hasReachMax;

  /// All saved accounts, ignoring the search filter.
  final int total;

  const AccountState(
      {this.accounts,
      this.message,
      this.hasReachMax = false,
      this.total = 0,
      this.status = AccountStatusCubit.loading});
}
