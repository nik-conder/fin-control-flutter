import 'package:dio/dio.dart';
import 'package:fin_control/data/services/api_clinet.dart';
import 'package:fin_control/data/services/user_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../../data/dataProvider/dao/profiles_dao.dart';
import '../../data/dataProvider/dao/session_dao.dart';
import '../../data/dataProvider/dao/settings_dao.dart';
import '../../data/dataProvider/dao/transactions_dao.dart';
import '../../data/dataProvider/database_manager.dart';
import '../../data/repository/account_repository.dart';
import '../../data/repository/profiles_repository.dart';
import '../../data/repository/session_repository.dart';
import '../../data/repository/settings_repository.dart';
import '../../data/repository/transactions_repository.dart';

class DataModule {
  static void register(GetIt getIt) {
    // Core
    getIt.registerSingleton<DatabaseManager>(SQLiteDatabase());
    getIt.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());

    // DAO
    getIt.registerFactory<SettingsDao>(
        () => SettingsDao(getIt<DatabaseManager>()));

    getIt.registerFactory<ProfilesDAO>(
        () => ProfilesDAO(getIt<DatabaseManager>()));

    getIt.registerFactory<SessionDao>(
        () => SessionDao(getIt<DatabaseManager>()));

    getIt.registerFactory<TransactionsDao>(
        () => TransactionsDao(getIt<DatabaseManager>()));

    // Dio
    getIt.registerLazySingleton<Dio>(() => ApiClient.createDio());

    // Services
    getIt.registerLazySingleton<UsersService>(() => UsersService(getIt<Dio>()));

    // Repositories
    getIt.registerLazySingleton<SettingsRepository>(() => SettingsRepository(
        getIt<SettingsDao>(), getIt<FlutterSecureStorage>()));

    getIt.registerLazySingleton<ProfilesRepository>(
        () => ProfilesRepository(getIt<ProfilesDAO>(), getIt<UsersService>()));

    getIt.registerLazySingleton<SessionRepository>(
        () => SessionRepository(getIt<SessionDao>()));

    getIt.registerLazySingleton<TransactionsRepository>(
        () => TransactionsRepository(getIt<TransactionsDao>()));

    getIt.registerLazySingleton<AccountRepository>(
      () => AccountRepository(getIt<UsersService>()),
    );
  }
}
