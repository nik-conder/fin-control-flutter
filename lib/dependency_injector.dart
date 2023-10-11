import 'package:fin_control/data/dataProvider/dao/profiles_dao.dart';
import 'package:fin_control/data/dataProvider/dao/settings_dao.dart';
import 'package:fin_control/data/dataProvider/database_manager.dart';
import 'package:fin_control/data/repository/profiles_repository.dart';
import 'package:fin_control/data/repository/settings_repository.dart';
import 'package:fin_control/domain/bloc/home/home_bloc.dart';
import 'package:fin_control/domain/bloc/profile/profile_bloc.dart';
import 'package:fin_control/domain/bloc/settings/settings_bloc.dart';
import 'package:fin_control/domain/bloc/theme/theme_bloc.dart';
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

    getIt.registerFactory<ThemeBloc>(
        () => ThemeBloc(getIt<SettingsRepository>()));

    getIt.registerFactory<HomeBloc>(() => HomeBloc());

    getIt.registerFactory<ProfileBloc>(
        () => ProfileBloc(getIt<ProfilesRepository>()));

    getIt.registerFactory<SettingsBloc>(
        () => SettingsBloc(getIt<SettingsRepository>()));
  }
}
