import 'package:fin_control/data/dataProvider/dao/settings_dao.dart';
import 'package:fin_control/dependency_injector.dart';
import 'package:fin_control/data/models/settings.dart';
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

    test('Insert Setting', () async {
      final settings = Settings(id: 1, isDarkMode: 1);
      final insertedRows = await settingsDao.insertSettings(settings);

      expect(insertedRows, 1);
    });

    test('Update option "Dark Mode"', () async {
      final updatedRows = await settingsDao.updateDarkModeSetting(1);

      expect(updatedRows, 1);
    });

    test('Get option "Dark Mode', () async {
      final darkModeSetting = await settingsDao.getDarkModeSetting();

      expect(darkModeSetting, 1);
    });

    tearDown(() {
      getIt.reset();
    });
  });
}
