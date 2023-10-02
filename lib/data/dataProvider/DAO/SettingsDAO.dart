import 'package:fin_control/data/dataProvider/DatabaseManager.dart';
import 'package:fin_control/data/models/Settings.dart';
import 'package:sqflite/sqlite_api.dart';

class SettingsDao {
  final DatabaseManager databaseManager;

  SettingsDao(this.databaseManager);

  Future<void> saveSettings(Settings settings) async {
    final database = await databaseManager.initializeDB();
    await database.insert(
      'settings',
      {'isDarkMode': settings.isDarkMode ? 1 : 0},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Settings> getSettings() async {
    final database = await databaseManager.initializeDB();
    final result = await database.query('settings');
    if (result.isNotEmpty) {
      final isDarkMode = result.first['isDarkMode'] == 1;
      return Settings(isDarkMode: isDarkMode);
    }
    return const Settings(
        isDarkMode: false); // Default value if no settings found
  }
}
