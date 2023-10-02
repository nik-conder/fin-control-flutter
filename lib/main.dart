import 'package:fin_control/data/dataProvider/DAO/SettingsDAO.dart';
import 'package:fin_control/data/dataProvider/DatabaseManager.dart';
import 'package:fin_control/data/repository/SettingsRepository.dart';
import 'package:fin_control/domain/DarkModeUseCase.dart';
import 'package:fin_control/presentation/bloc/home_bloc.dart';
import 'package:fin_control/presentation/ui/home/HomePage.dart';
import 'package:fin_control/presentation/ui/settings/SettingsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

GetIt getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<DatabaseManager>(() => SQLiteDatabase());

  getIt.registerFactory<SettingsDao>(() {
    final databaseManager = getIt<DatabaseManager>();
    return SettingsDao(databaseManager);
  });

  getIt.registerFactory<SettingsRepository>(() {
    final settingsDao = getIt<SettingsDao>();
    return SettingsRepository(settingsDao);
  });

  getIt.registerFactory<DarkModeUseCase>(() {
    final settingsRepository = getIt<SettingsRepository>();
    return DarkModeUseCase(settingsRepository);
  });
}

void setupDatabaseFactory() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
}

void main() {
  setupDependencies();
  setupDatabaseFactory(); // Инициализируем databaseFactory
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            brightness: Brightness.light,
            useMaterial3: true,
          ),
          themeMode: ThemeMode.dark,
          home: const HomePage(),
          routes: <String, WidgetBuilder>{
            '/settings': (BuildContext context) => const SettingsPage(),
          }),
    );
  }
}
