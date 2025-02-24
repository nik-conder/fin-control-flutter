import 'package:fin_control/data/dataProvider/dao/settings_dao.dart';
import 'package:fin_control/data/models/settings.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SettingsRepository {
  final SettingsDao settingsDao;
  final FlutterSecureStorage secureStorage;

  SettingsRepository(this.settingsDao, this.secureStorage);

  Future<int> insertSettings(Settings settings) async {
    return await settingsDao.insertSettings(settings);
  }

  Future<Settings> getSettings() async {
    return await settingsDao.getSettings();
  }

  Future<int> updateDarkModeSetting(bool isDarkMode) async {
    return await settingsDao.updateDarkModeSetting((isDarkMode) ? 1 : 0);
  }

  Future<bool> getDarkModeSetting() async {
    final result = settingsDao.getDarkModeSetting();
    return result;
  }

  Future<void> saveToken(String token) async {
    await secureStorage.write(key: 'token', value: token);
  }

  Future<String?> getToken() async {
    return await secureStorage.read(key: 'token');
  }
}
