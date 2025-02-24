import 'package:fin_control/domain/useCases/get_accounts.dart';
import 'package:fin_control/domain/useCases/settings_use_case.dart';
import 'package:get_it/get_it.dart';

import '../../domain/useCases/session_use_case.dart';

class DomainModule {
  static void register(GetIt getIt) {
    // UseCase
    getIt.registerLazySingleton<SessionUseCase>(() => SessionUseCase(getIt()));
    getIt.registerLazySingleton<GetAccounts>(() => GetAccounts(getIt()));
    getIt
        .registerLazySingleton<SettingsUseCase>(() => SettingsUseCase(getIt()));
  }
}
