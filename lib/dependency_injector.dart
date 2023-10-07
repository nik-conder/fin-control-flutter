import 'package:fin_control/data/dataProvider/dao/profiles_dao.dart';
import 'package:fin_control/data/dataProvider/dao/settings_dao.dart';
import 'package:fin_control/data/dataProvider/database_manager.dart';
import 'package:fin_control/data/repository/profiles_repository.dart';
import 'package:fin_control/data/repository/settings_repository.dart';
import 'package:get_it/get_it.dart';

class DependencyInjector {
  static final GetIt getIt = GetIt.instance;

  static void setup() {
    getIt.registerSingleton<DatabaseManager>(SQLiteDatabase());
    getIt.registerFactory<SettingsDao>(
        () => SettingsDao(getIt<DatabaseManager>()));
    getIt.registerFactory<ProfilesDAO>(
        () => ProfilesDAO(getIt<DatabaseManager>()));

    getIt.registerFactory<SettingsRepository>(
        () => SettingsRepository(getIt<SettingsDao>()));
    getIt.registerFactory<ProfilesRepository>(
        () => ProfilesRepository(getIt<ProfilesDAO>()));
  }
}
