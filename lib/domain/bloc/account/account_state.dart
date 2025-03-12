import 'package:fin_control/data/models/account_dto.dart';

abstract class AccountState {}

class AccountLoading extends AccountState {}

class AccountLoaded extends AccountState {
  final List<AccountDto> accounts;
  AccountLoaded(this.accounts);
}

class AccountError extends AccountState {
  final String message;
  AccountError(this.message);
}
