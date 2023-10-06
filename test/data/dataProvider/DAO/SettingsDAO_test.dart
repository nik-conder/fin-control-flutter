import 'package:fin_control/DependencyInjector.dart';
import 'package:fin_control/data/dataProvider/DAO/SettingsDAO.dart';
import 'package:fin_control/data/models/Settings.dart';
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
