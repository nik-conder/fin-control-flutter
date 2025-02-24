import 'package:flutter_bloc/flutter_bloc.dart';

import '../../useCases/get_accounts.dart';
import 'account_event.dart';
import 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final GetAccounts getAccounts;

  AccountBloc(this.getAccounts) : super(AccountLoading()) {
    on<FetchAccounts>(_fetchAccounts);
  }

  _fetchAccounts(FetchAccounts event, Emitter<AccountState> emit) async {
    try {
      emit(AccountLoading());
      //delay for 2 seconds
      await Future.delayed(const Duration(seconds: 2));

      final accounts = await getAccounts();
      emit(AccountLoaded(accounts));
    } catch (e) {
      emit(AccountError(e.toString()));
    }
  }
}
