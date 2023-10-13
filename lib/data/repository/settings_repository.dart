import 'package:fin_control/data/dataProvider/dao/settings_dao.dart';
import 'package:fin_control/data/models/settings.dart';

class SettingsRepository {
  final SettingsDao settingsDao;

  SettingsRepository(this.settingsDao);

  Future<int> insertSettings(Settings settings) async {
    return await settingsDao.insertSettings(settings);
  }

  Future<Settings> getSettings() async {
    return await settingsDao.getSettings();
  }

  Future<int> updateDarkModeSetting(bool isDarkMode) async {
    return await settingsDao.updateDarkModeSetting((isDarkMode) ? 1 : 0);
  }

  Stream<bool> getDarkModeSetting() async* {
    final result = await settingsDao.getDarkModeSetting();
    yield* result;
  }
}
