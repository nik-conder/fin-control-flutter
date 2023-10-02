import 'package:fin_control/data/dataProvider/DAO/SettingsDAO.dart';
import 'package:fin_control/data/models/Settings.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fin_control/data/dataProvider/DatabaseManager.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  group('SettingsDao Tests', () {
    late SettingsDao settingsDao;
    late SQLiteDatabase database;

    setUp(() {
      // Инициализация базы данных перед каждым тестом
      databaseFactory = databaseFactoryFfi;
      database = SQLiteDatabase();
      settingsDao = SettingsDao(database);
    });

    test('initializeDB() should create the settings table', () async {
      expect(database, isNotNull);
    });

    test('Update Dark Mode Setting', () async {
      final db = await database.initializeDB();
      expect(db, isNotNull);

      final updatedRows = await settingsDao.updateDarkModeSetting(1);

      // // Проверяем, что количество обновленных строк равно 1
      expect(updatedRows, 1);
    });

    test('Get Dark Mode Setting', () async {
      // Перед тестом убедитесь, что в базе данных есть запись с id=1 и полем 'isDarkMode'
      final darkModeSetting = await settingsDao.getDarkModeSetting();

      // Проверяем, что значение 'isDarkMode' является числом (int) и равно 0 или 1
      expect(darkModeSetting, isA<int>());
      expect(darkModeSetting, isIn([0, 1]));
    });
  });
}
