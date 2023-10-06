import 'package:fin_control/data/repository/SettingsRepository.dart';

class DarkModeUseCase {
  final SettingsRepository settingsRepository;

  DarkModeUseCase(this.settingsRepository);

  Future<int> isDarkMode(bool isDarkMode) {
    final result = settingsRepository.updateDarkModeSetting(isDarkMode);
    return result;
  }

  Future<int> getDarkMode() {
    final result = settingsRepository.getDarkModeSetting();
    return result;
  }
}
