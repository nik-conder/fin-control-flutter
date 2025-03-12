import 'package:fin_control/data/repository/settings_repository.dart';
import 'package:fin_control/data/repository/token_repository.dart';
import 'package:fin_control/domain/useCases/auth_use_case.dart';
import 'package:fin_control/domain/useCases/settings_use_case.dart';
import 'package:get_it/get_it.dart';

import '../../data/services/encryptor.dart';

class DomainModule {
  static void register(GetIt getIt) {
    // UseCase
    getIt.registerLazySingleton<SettingsUseCase>(() => SettingsUseCase(
          getIt<SettingsRepository>(),
        ));
    getIt.registerLazySingleton<AuthUseCase>(() => AuthUseCase(
          getIt<TokenRepository>(),
          getIt<Encryptor>(),
        ));
  }
}
