import 'package:fin_control/dependency_injector.dart';
import 'package:fin_control/data/dataProvider/dao/profiles_dao.dart';
import 'package:fin_control/data/models/profile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

void main() {
  group('ProfilesDAO Tests', () {
    final getIt = GetIt.instance;

    const String profileName = 'Test prfile #1';

    late ProfilesDAO profileDao;

    setUp(() {
      DependencyInjector.setup();
      profileDao = getIt<ProfilesDAO>();
    });

    test('Insert Profile', () async {
      final settings = Profile(id: 1, name: profileName);

      final insertedRows = await profileDao.insertProfile(settings);

      expect(insertedRows, 1);
    });

    test('Get name by id', () async {
      final result = await profileDao.getName(1);

      expect(result, profileName);
    });

    test('Get profile by id', () async {
      final result = profileDao.getProfile(1);
      result.listen((profile) {
        expect(profile.name, profileName);
        expect(profile.id, 1);
      });
    });

    tearDown(() {
      getIt.reset();
    });
  });
}
