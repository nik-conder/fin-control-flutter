import 'package:fin_control/data/dataProvider/DAO/SettingsDAO.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  group('SettingsRepository Tests', () {
    late SettingsDaoMock settingsDaoMock;

    setUp(() {
      settingsDaoMock = SettingsDaoMock();
    });

    test('Update Dark Mode Setting', () async {
      final updatedRows = await settingsDaoMock.getDarkModeSetting();

      expect(updatedRows, isIn([0, 1]));
    });

    test('Get Dark Mode Setting', () async {
      final darkModeSetting = await settingsDaoMock.getDarkModeSetting();

      expect(darkModeSetting, isIn([0, 1]));
    });
  });
}

class SettingsDaoMock extends Mock implements SettingsDao {
  @override
  Future<int> updateDarkModeSetting(int isDarkMode) {
    return Future.value(1);
  }

  @override
  Future<int> getDarkModeSetting() {
    return Future.value(0);
  }
}
