import '../../data/models/settings.dart';
import '../../data/repository/settings_repository.dart';

class SettingsUseCase {
  final SettingsRepository _settingsRepository;

  SettingsUseCase(this._settingsRepository);

  Future<int> insertSettings(Settings settings) async {
    return await _settingsRepository.insertSettings(settings);
  }

  Future<Settings> getSettings() async {
    return await _settingsRepository.getSettings();
  }

  Future<int> updateDarkModeSetting(bool isDarkMode) async {
    return await _settingsRepository
        .updateDarkModeSetting(((isDarkMode) ? 1 : 0) as bool);
  }

  Future<bool> getDarkModeSetting() async {
    final result = _settingsRepository.getDarkModeSetting();
    return result;
  }

  Future<void> saveToken(String token) async {
    await _settingsRepository.saveToken(token);
  }

  Future<String?> getToken() async {
    return await _settingsRepository.getToken();
  }
}
