import 'package:fin_control/data/models/account_dto.dart';

import '../services/user_service.dart';

class AccountRepository {
  final UsersService service;

  AccountRepository(this.service);

  @override
  Future<List<AccountDto>> getAccounts() async {
    final dtos = await service.fetchAccounts();
    return dtos
        .map((dto) => AccountDto(
              id: dto.id,
              name: dto.name,
              type: dto.type,
              openedDate: dto.openedDate,
              closedDate: dto.closedDate,
              // status: dto.status,
              // accessLevel: dto.accessLevel,
            ))
        .toList();
  }
}
