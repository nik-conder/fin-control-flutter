import 'package:fin_control/data/models/Settings.dart';
import 'package:fin_control/data/repository/SettingsRepository.dart';

class DarkModeUseCase {
  final SettingsRepository settingsRepository;

  DarkModeUseCase(this.settingsRepository);

  void isDarkMode(bool isDarkMode) {
    final result = settingsRepository.saveDarkModeSetting(isDarkMode);
    print(result);
  }

  Future<Settings> getDarkMode() {
    final result = settingsRepository.getSettings();
    print("dark mode: ${result}");
    return result;
  }
}
