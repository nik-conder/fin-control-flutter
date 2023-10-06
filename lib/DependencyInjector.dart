import 'package:fin_control/data/dataProvider/DAO/SettingsDAO.dart';
import 'package:fin_control/data/dataProvider/DatabaseManager.dart';
import 'package:fin_control/data/repository/SettingsRepository.dart';
import 'package:fin_control/domain/DarkModeUseCase.dart';
import 'package:get_it/get_it.dart';

class DependencyInjector {
  static final databaseManager = getIt<DatabaseManager>();
  static final settingsDao = getIt<SettingsDao>();

  static final GetIt getIt = GetIt.instance;

  static void setup() {
    getIt.registerSingleton<DatabaseManager>(SQLiteDatabase());

    getIt.registerFactory<SettingsDao>(() {
      return SettingsDao(databaseManager);
    });

    getIt.registerFactory<SettingsRepository>(() {
      return SettingsRepository(settingsDao);
    });

    getIt.registerFactory<DarkModeUseCase>(() {
      final settingsRepository = getIt<SettingsRepository>();
      return DarkModeUseCase(settingsRepository);
    });
  }
}
