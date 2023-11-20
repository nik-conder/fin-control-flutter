import 'package:fin_control/data/dataProvider/dao/profiles_dao.dart';
import 'package:fin_control/data/dataProvider/dao/session_dao.dart';
import 'package:fin_control/data/dataProvider/dao/settings_dao.dart';
import 'package:fin_control/data/dataProvider/dao/transactions_dao.dart';
import 'package:fin_control/data/dataProvider/database_manager.dart';
import 'package:fin_control/data/repository/profiles_repository.dart';
import 'package:fin_control/data/repository/session_repository.dart';
import 'package:fin_control/data/repository/settings_repository.dart';
import 'package:fin_control/data/repository/transactions_repository.dart';
import 'package:fin_control/domain/bloc/profile/profile_bloc.dart';
import 'package:fin_control/domain/bloc/session/session_bloc.dart';
import 'package:fin_control/domain/bloc/settings/settings_bloc.dart';
import 'package:fin_control/domain/bloc/theme/theme_bloc.dart';
import 'package:fin_control/domain/bloc/transactions/transactions_bloc.dart';
import 'package:get_it/get_it.dart';

class DependencyInjector {
  static final GetIt getIt = GetIt.instance;

  static void setup() {
    getIt.registerSingleton<DatabaseManager>(SQLiteDatabase());
    // DAO

    getIt.registerFactory<SettingsDao>(
            () => SettingsDao(getIt<DatabaseManager>()));

    getIt.registerFactory<ProfilesDAO>(
            () => ProfilesDAO(getIt<DatabaseManager>()));

    getIt.registerFactory<SessionDao>(
            () => SessionDao(getIt<DatabaseManager>()));

    getIt.registerFactory<TransactionsDao>(
            () => TransactionsDao(getIt<DatabaseManager>()));

    // Repositories

    getIt.registerFactory<SettingsRepository>(
            () => SettingsRepository(getIt<SettingsDao>()));

    getIt.registerFactory<ProfilesRepository>(
            () => ProfilesRepository(getIt<ProfilesDAO>()));

    getIt.registerFactory<SessionRepository>(
            () => SessionRepository(getIt<SessionDao>()));

    getIt.registerFactory<TransactionsRepository>(
            () => TransactionsRepository(getIt<TransactionsDao>()));

    // BloCs
    getIt.registerFactory<ThemeBloc>(
            () => ThemeBloc(getIt<SettingsRepository>()));

    getIt.registerFactory<ProfileBloc>(() => ProfileBloc());

    getIt.registerFactory<SettingsBloc>(
            () => SettingsBloc(getIt<SettingsRepository>()));

    getIt.registerFactory<SessionBloc>(() => SessionBloc());

    getIt.registerFactory<TransactionsBloc>(
            () => TransactionsBloc(getIt<TransactionsRepository>()));
  }
}