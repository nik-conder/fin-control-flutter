import 'package:fin_control/dependency_injector.dart';
import 'dart:developer' as developer;
import 'package:fin_control/data/dataProvider/dao/profiles_dao.dart';
import 'package:fin_control/data/models/profile.dart';
import 'package:flutter/foundation.dart';
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
      debugPrint('Profile name: $result');
      expect(result, profileName);
    });

    test('Get profile by id', () async {
      final result = profileDao.getProfile(1);

      result.then((value) => {
            expect(value, isNotNull),
            expect(value.name, profileName),
            debugPrint('Profile: ${value.name}'),
          });
    });

    test('Get all profiles', () {
      final result = profileDao.getAllProfiles();

      debugPrint('All profiles: $result');

      result.listen((value) => {
            expect(value, isNotNull),
            expect(value.length, 1),
            expect(value[0].name, profileName),
            expect(value[0].id, 1),
            debugPrint('Profile: ${value[0].name}'),
          });
    });

    tearDown(() {
      getIt.reset();
    });
  });
}
