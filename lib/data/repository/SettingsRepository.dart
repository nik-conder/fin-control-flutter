import 'package:fin_control/data/dataProvider/DAO/SettingsDAO.dart';
import 'package:fin_control/data/models/Settings.dart';

class SettingsRepository {
  final SettingsDao settingsDao;

  SettingsRepository(this.settingsDao);

  Future<void> saveDarkModeSetting(bool isDarkMode) async {
    final result = await settingsDao.getSettings();
    print(result);
    print("...");
  }

  Future<Settings> getSettings() async {
    final result = await settingsDao.getSettings();
    print(result.isDarkMode);
    return Settings(isDarkMode: result.isDarkMode);
  }
}
