import 'package:fin_control/data/models/currency.dart';
import 'package:fin_control/dependency_injector.dart';
import 'package:fin_control/data/models/profile.dart';
import 'package:fin_control/data/repository/profiles_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

void main() {
  group('ProfilesRepository Tests', () {
    GetIt getIt = GetIt.instance;

    const String profileName = 'Test prfile #1';
    const double profileBalance = 123456.789;
    const Currency profileCurrency = Currency.usd;

    late ProfilesRepository profilesRepository;

    setUpAll(() {
      DependencyInjector.setup();
    });

    setUp(() {
      profilesRepository = getIt<ProfilesRepository>();
    });

    tearDownAll(() {
      getIt.reset();
    });

    test('Insert Profile', () async {
      final profile = Profile(
          id: 1,
          name: profileName,
          balance: profileBalance,
          currency: profileCurrency);

      final insertedRows = await profilesRepository.insertProfile(profile);

      expect(insertedRows, 1);
    });

    test('Get name by id', () async {
      final result = await profilesRepository.getName(1);

      expect(result, 'Test prfile #1');
    });

    test('Get profile by id', () async {
      final result = profilesRepository.getProfile(1);

      result.then((value) => {
            expect(value, isNotNull),
            expect(value.name, profileName),
            expect(value.id, 1),
            expect(value.balance, profileBalance),
            expect(value.currency, profileCurrency),
            debugPrint('Profile: ${value.name}'),
          });
    });

    test('Get all profiles', () {
      final result = profilesRepository.getAllProfiles();

      result.listen((event) {
        expect(event, isNotNull);
        expect(event.length, 1);
        expect(event[0].name, profileName);
        expect(event[0].id, 1);
        expect(event[0].balance, profileBalance);
        expect(event[0].currency, profileCurrency);
        debugPrint('Profile: ${event[0].name}');
      });
    });

    group('Balance', () {
      test('Get profile balance', () async {
        final result = await profilesRepository.getBalance(1);

        debugPrint('Balance: $result');

        result.listen((event) {
          expect(event, profileBalance);
        });
      });

      test('Update balance: + 100500', () async {
        final result = await profilesRepository.updateBalance(1, 100500);

        expect(1, result);

        final getBalance = await profilesRepository.getBalance(1);

        const resultBalance = 100500;

        getBalance.listen((event) {
          expect(event, resultBalance);
        });
      });
    });
  });
}
