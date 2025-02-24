import 'package:fin_control/data/models/account_dto.dart';

import '../../data/repository/account_repository.dart';

class GetAccounts {
  final AccountRepository repository;

  GetAccounts(this.repository);

  Future<List<AccountDto>> call() async {
    return await repository.getAccounts();
  }
}
