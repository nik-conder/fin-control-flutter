import 'package:fin_control/dependency_injector.dart';
import 'package:fin_control/data/dataProvider/dao/profiles_dao.dart';
import 'package:fin_control/data/models/profile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

void main() {
  group('ProfilesDAO Tests', () {
    final getIt = GetIt.instance;

    const String profileName = 'Test prfile #1';
    const double profileBalance = 123456.789;

    late ProfilesDAO profileDao;

    setUp(() {
      DependencyInjector.setup();
      profileDao = getIt<ProfilesDAO>();
    });

    test('Insert Profile', () async {
      final settings =
          Profile(id: 1, name: profileName, balance: profileBalance);

      final insertedRows = await profileDao.insertProfile(settings);

      expect(1, insertedRows);
    });

    test('Get name by id', () async {
      final result = await profileDao.getName(1);
      debugPrint('Profile name: $result');
      expect(profileName, result);
    });

    test('Get profile by id', () async {
      final result = await profileDao.getProfile(1);

      expect(result, isNotNull);
      expect(result.name, profileName);
      expect(result.balance, profileBalance);
      debugPrint('Profile: ${result.name}');
    });

    test('Get all profiles', () async {
      final result = await profileDao.getAllProfiles();

      debugPrint('All profiles: $result');

      result.listen((value) => {
            expect(value, isNotNull),
            expect(value.length, 1),
            expect(value[0].name, profileName),
            expect(value[0].id, 1),
            debugPrint('Profile: ${value[0].name}'),
          });
    });

    group('Balance', () {
      test('Get profile balance', () async {
        final result = await profileDao.getBalance(1);

        debugPrint('Balance: $result');

        result.listen((event) {
          expect(event, profileBalance);
        });
      });

      test('Update balance: + 100500', () async {
        final result = await profileDao.updateBalance(1, 100500);

        expect(1, result);

        final getBalance = await profileDao.getBalance(1);

        const resultBalance = 100500;

        getBalance.listen((event) {
          expect(event, resultBalance);
        });
      });
    });

    tearDown(() {
      getIt.reset();
    });
  });
}
