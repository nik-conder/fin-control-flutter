import 'package:fin_control/data/dataProvider/DAO/SettingsDAO.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fin_control/data/dataProvider/DatabaseManager.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  group('SettingsDao Tests', () {
    late SettingsDao settingsDao;
    late SQLiteDatabase database;

    setUp(() {
      databaseFactory = databaseFactoryFfi;
      database = SQLiteDatabase();
      settingsDao = SettingsDao(database);
    });

    test('initializeDB() should create the settings table', () async {
      expect(database, isNotNull);
    });

    test('Update Dark Mode Setting', () async {
      final updatedRows = await settingsDao.updateDarkModeSetting(1);

      expect(updatedRows, 1);
    });

    test('Get Dark Mode Setting', () async {
      final darkModeSetting = await settingsDao.getDarkModeSetting();

      expect(darkModeSetting, isA<int>());
      expect(darkModeSetting, isIn([0, 1]));
    });
  });
}
