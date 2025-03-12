import 'package:dio/dio.dart';
import 'package:encrypt/encrypt.dart';
import 'package:fin_control/data/repository/token_repository.dart';
import 'package:fin_control/data/services/aes_encryptor.dart';
import 'package:fin_control/data/services/api_clinet.dart';
import 'package:fin_control/data/services/secure_storage.dart';
import 'package:fin_control/data/services/user_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
import '../../data/services/encryptor.dart';

class DataModule {
  static void register(GetIt getIt) async {
    final key =
        Key.fromUtf8('32characterslongpassphrase123456'.padRight(32, '0'));
    final iv = IV.fromLength(16);

    final prefs = await SharedPreferences.getInstance();

    getIt.registerSingleton<SharedPreferences>(prefs);

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

    getIt.registerLazySingleton<ApiClient>(() {
      return ApiClient('test'); // TODO
    });

    // Dio
    getIt.registerLazySingleton<Dio>(() => getIt<ApiClient>().dio);

    // Services
    getIt.registerLazySingleton<UsersService>(() => UsersService(getIt<Dio>()));

    getIt.registerSingleton<Encryptor>(AesEncryptor(key: key, iv: iv));
    getIt.registerSingleton<SecureStorage>(
        SecureStorage(getIt<SharedPreferences>()));

    // Repositories
    getIt.registerLazySingleton<SettingsRepository>(
        () => SettingsRepository(getIt<SettingsDao>()));

    getIt.registerLazySingleton<ProfilesRepository>(
        () => ProfilesRepository(getIt<ProfilesDAO>(), getIt<UsersService>()));

    getIt.registerLazySingleton<SessionRepository>(
        () => SessionRepository(getIt<SessionDao>()));

    getIt.registerLazySingleton<TransactionsRepository>(
        () => TransactionsRepository(getIt<TransactionsDao>()));

    getIt.registerLazySingleton<AccountRepository>(
      () => AccountRepository(getIt<UsersService>()),
    );

    getIt.registerLazySingleton<TokenRepository>(
        () => TokenRepository(getIt<SecureStorage>()));
  }
}
