import 'package:fin_control/dependency_injector.dart';
import 'package:fin_control/data/models/settings.dart';
import 'package:fin_control/data/repository/settings_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

void main() {
  group('SettingsRepository Tests', () {
    GetIt getIt = GetIt.instance;

    late SettingsRepository settingsRepository;

    setUp(() {
      DependencyInjector.setup();
      settingsRepository = getIt<SettingsRepository>();
    });

    test('Check Auto Insert Setting', () async {
      final insertedRows = await settingsRepository.getSettings();

      expect(insertedRows.id, 1);
      expect(insertedRows.isDarkMode, 0);
    });

    test('Update option "Dark Mode', () async {
      final updatedRows = await settingsRepository.updateDarkModeSetting(true);

      expect(updatedRows, 1);
    });

    test('Get option "Dark Mode', () async {
      final darkModeSetting = await settingsRepository.getDarkModeSetting();
      darkModeSetting.listen((event) {
        expect(event, true);
      });
    });

    tearDown(() {
      getIt.reset();
    });
  });
}
