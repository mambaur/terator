part of 'account_cubit.dart';

enum AccountStatusCubit { loading, success, failure }

@immutable
class AccountState {
  final AccountStatusCubit? status;
  final List<AccountModel>? accounts;
  final String? message;
  final bool hasReachMax;

  const AccountState(
      {this.accounts,
      this.message,
      this.hasReachMax = false,
      this.status = AccountStatusCubit.loading});
}
