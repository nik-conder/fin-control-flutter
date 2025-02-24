import 'package:fin_control/data/dataProvider/dao/settings_dao.dart';
import 'package:fin_control/data/models/settings.dart';
import 'package:fin_control/core/dependency_injector.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

void main() {
  group('SettingsDao Tests', () {
    final getIt = GetIt.instance;

    final Settings settings = Settings(id: 1, isDarkMode: 0);

    late SettingsDao settingsDao;

    setUpAll(() => DependencyInjector.setup());

    setUp(() {
      settingsDao = getIt<SettingsDao>();
    });

    test('Check Auto Insert Setting', () async {
      final insertedRows = await settingsDao.getSettings();
      expect(settings.id, insertedRows.id);
      expect(settings.isDarkMode, insertedRows.isDarkMode);
    });

    test('Check no more one row', () async {
      final insertedRows = await settingsDao.getSettings();

      expect(settings.id, insertedRows.id);
      if (insertedRows.id > 1) fail('There should be only one row');
      expect(settings.isDarkMode, insertedRows.isDarkMode);
    });

    group('Dark mode', () {
      test('Update option "Dark Mode"', () async {
        final updatedRows = await settingsDao.updateDarkModeSetting(1);

        expect(1, updatedRows);
      });

      test('Get option "Dark Mode', () async {
        final result = settingsDao.getDarkModeSetting();

        result.then((value) => {
              expect(true, value),
            });
      });
    });

    tearDownAll(() {
      getIt.reset();
    });
  });
}
