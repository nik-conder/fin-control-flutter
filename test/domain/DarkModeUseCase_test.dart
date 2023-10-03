import 'package:fin_control/data/repository/SettingsRepository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  group("DarkModeUseCase Tests", () {
    test("Update Dark Mode Setting", () async {
      final updatedRows =
          await SettingsRepositoryMock().updateDarkModeSetting(true);

      expect(updatedRows, 1);
    });

    test("Get Dark Mode Setting", () async {
      final darkModeSetting =
          await SettingsRepositoryMock().getDarkModeSetting();

      expect(darkModeSetting, 0);
    });
  });
}

class SettingsRepositoryMock extends Mock implements SettingsRepository {
  @override
  Future<int> updateDarkModeSetting(bool isDarkMode) {
    return Future.value(1);
  }

  @override
  Future<int> getDarkModeSetting() {
    return Future.value(0);
  }
}
