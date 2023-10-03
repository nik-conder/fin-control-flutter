import 'package:fin_control/data/dataProvider/DAO/SettingsDAO.dart';

class SettingsRepository {
  final SettingsDao settingsDao;

  SettingsRepository(this.settingsDao);

  Future<int> updateDarkModeSetting(bool isDarkMode) async {
    return await settingsDao.updateDarkModeSetting((isDarkMode) ? 1 : 0);
  }

  Future<int> getDarkModeSetting() async {
    final result = await settingsDao.getDarkModeSetting();
    return result;
  }
}
