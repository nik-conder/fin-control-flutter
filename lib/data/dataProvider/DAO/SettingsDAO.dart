import 'package:fin_control/data/dataProvider/DatabaseManager.dart';
import 'package:fin_control/data/models/Settings.dart';
import 'package:sqflite/sqlite_api.dart';

class SettingsDao {
  final DatabaseManager databaseManager;

  SettingsDao(this.databaseManager);

  Future<int> insertSettings(Settings settings) async {
    final database = await databaseManager.initializeDB();

    try {
      final result = await database.rawInsert(
          'INSERT INTO settings (id, isDarkMode) VALUES (?, ?)',
          [settings.id, settings.isDarkMode]);
      print('Inserted Rows: $result');
      return result;
    } catch (e) {
      print('Error inserting rows: $e');
      return 0;
    }
  }

  Future<int> updateDarkModeSetting(int isDarkMode) async {
    final database = await databaseManager.initializeDB();

    try {
      final updatedRows = await database
          .update('settings', {'isDarkMode': isDarkMode}, where: 'id = 1');
      print('Updated Rows: $updatedRows');

      return updatedRows;
    } catch (e) {
      print('Error updating rows: $e');
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
      print('Error getting dark mode setting: $e');
      return 0;
    }
  }
}
