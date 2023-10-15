import 'package:fin_control/data/dataProvider/dao/settings_dao.dart';
import 'package:fin_control/dependency_injector.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

void main() {
  group('SettingsDao Tests', () {
    final getIt = GetIt.instance;

    late SettingsDao settingsDao;

    setUp(() {
      DependencyInjector.setup();
      settingsDao = getIt<SettingsDao>();
    });

    test('Check Auto Insert Setting', () async {
      final insertedRows = await settingsDao.getSettings();

      expect(insertedRows.id, 1);
      expect(insertedRows.isDarkMode, 0);
    });

    group('Dark mode', () {
      test('Update option "Dark Mode"', () async {
        final updatedRows = await settingsDao.updateDarkModeSetting(1);

        expect(updatedRows, 1);
      });

      test('Get option "Dark Mode', () async {
        final darkModeSetting = await settingsDao.getDarkModeSetting();

        darkModeSetting.listen((event) {
          expect(event, true);
        });
      });
    });

    tearDown(() {
      getIt.reset();
    });
  });
}
