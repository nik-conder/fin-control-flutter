import 'package:fin_control/data/dataProvider/database_manager.dart';
import 'package:fin_control/data/models/settings.dart';
import 'dart:developer' as developer;

class SettingsDao {
  final DatabaseManager databaseManager;
  final _columnName = 'settings';

  SettingsDao(this.databaseManager);

  Future<int> insertSettings(Settings settings) async {
    final database = await databaseManager.initializeDB();

    try {
      final result = await database.rawInsert(
          'INSERT INTO settings (id, isDarkMode) VALUES (?, ?)',
          [settings.id, settings.isDarkMode]);
      developer.log('Inserted Rows: $result', time: DateTime.now());

      return result;
    } catch (e) {
      developer.log('',
          time: DateTime.now(), error: 'Error inserting settings');
      return 0;
    }
  }

  Future<int> updateDarkModeSetting(int isDarkMode) async {
    final database = await databaseManager.initializeDB();

    try {
      final updatedRows = await database
          .update(_columnName, {'isDarkMode': isDarkMode}, where: 'id = 1');
      developer.log('Updated Rows: $updatedRows', time: DateTime.now());

      return updatedRows;
    } catch (e) {
      developer.log('',
          time: DateTime.now(), error: 'Error updating dark mode setting');
      return 0;
    }
  }

  Future<int> getDarkModeSetting() async {
    try {
      final database = await databaseManager.initializeDB();
      final result = await database.query('settings', columns: ['isDarkMode']);

      if (result.isNotEmpty) {
        return result.first['isDarkMode'] as int;
      } else {
        return 0;
      }
    } catch (e) {
      developer.log('',
          time: DateTime.now(), error: 'Error getting dark mode setting');
      return 0;
    }
  }
}
