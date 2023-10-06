import 'package:fin_control/DependencyInjector.dart';
import 'package:fin_control/data/dataProvider/DAO/SettingsDAO.dart';
import 'package:fin_control/data/models/Settings.dart';
import 'package:fin_control/domain/DarkModeUseCase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

void main() {
  group("DarkModeUseCase Tests", () {
    GetIt getIt = GetIt.instance;

    late DarkModeUseCase darkModeUseCase;
    late SettingsDao settingsDao;

    setUp(() {
      DependencyInjector.setup();
      darkModeUseCase = getIt<DarkModeUseCase>();
      settingsDao = getIt<SettingsDao>();
    });

    test('Insert Settings', () async {
      final settings = Settings(id: 1, isDarkMode: 1);
      final insertedRows = await settingsDao.insertSettings(settings);

      expect(insertedRows, 1);
    });

    test('Update option "Dark Mode"', () async {
      final updatedRows = await darkModeUseCase.isDarkMode(true);

      expect(updatedRows, 1);
    });

    test('Get option "Dark Mode"', () async {
      final darkModeSetting = await darkModeUseCase.getDarkMode();

      expect(darkModeSetting, 1);
    });

    tearDown(() {
      getIt.reset();
    });
  });
}
