import 'package:fin_control/data/dataProvider/dao/profiles_dao.dart';
import 'package:fin_control/data/models/currency.dart';
import 'package:fin_control/data/models/profile.dart';
import 'package:fin_control/dependency_injector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

void main() {
  group('ProfilesDAO Tests', () {
    final getIt = GetIt.instance;

    final profile1 = Profile(
        id: 1,
        name: "Test prfile #1",
        balance: 123456.789,
        currency: Currency.usd);

    late ProfilesDAO profileDao;

    setUp(() {
      DependencyInjector.setup();
      profileDao = getIt<ProfilesDAO>();
    });

    test('Insert Profile', () async {
      final insertedRows = await profileDao.insertProfile(profile1);
      expect(1, insertedRows);
    });

    test('Get name by id', () async {
      final result = await profileDao.getName(1);
      debugPrint('Profile name: $result');
      expect(profile1.name, result);
    });

    test('Get profile by id', () async {
      final result = await profileDao.getProfile(1);
      debugPrint('Profile: ${result.name} ${result.balance} ');
      expect(result, isNotNull);
      expect(1, result.id);
      expect(profile1.name, result.name);
      expect(profile1.balance, result.balance);
      expect(profile1.currency, result.currency);
    });

    test('Get all profiles', () async {
      final result = profileDao.getAllProfiles();

      debugPrint('All profiles: $result');

      result.listen((value) => {
            expect(value, isNotNull),
            expect(value.length, 1),
            expect(value[0].name, profile1.name),
            expect(value[0].id, 1),
            expect(value[0].balance, profile1.balance),
            debugPrint('Profile: ${value[0].name}'),
          });
    });

    group('Balance', () {
      test('Get profile balance', () async {
        final result = await profileDao.getBalance(1);

        debugPrint('Balance: $result');

        expect(result, profile1.balance);
      });

      test('Update balance: + 100500', () async {
        final result = await profileDao.updateBalance(1, profile1.balance);

        expect(1, result);

        final getBalance = await profileDao.getBalance(1);

        expect(profile1.balance, getBalance);
      });
    });

    tearDown(() {
      getIt.reset();
    });
  });
}
