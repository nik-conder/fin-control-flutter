import 'package:fin_control/data/models/currency.dart';
import 'package:fin_control/core/dependency_injector.dart';
import 'package:fin_control/data/models/profile.dart';
import 'package:fin_control/data/repository/profiles_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

void main() {
  group('ProfilesRepository Tests', () {
    GetIt getIt = GetIt.instance;

    final profile1 = Profile(
        id: 1,
        name: "Test prfile #1",
        balance: 123456.789,
        currency: Currency.usd);

    late ProfilesRepository profilesRepository;

    setUpAll(() {
      DependencyInjector.setup();
    });

    setUp(() {
      profilesRepository = getIt<ProfilesRepository>();
    });

    tearDownAll(() => getIt.reset());

    test('Insert Profile', () async {
      final profile = Profile(
          id: profile1.id,
          name: profile1.name,
          balance: profile1.balance,
          currency: profile1.currency);

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
            expect(value.name, profile1.name),
            expect(value.id, profile1.id),
            expect(value.balance, profile1.balance),
            expect(value.currency, profile1.currency),
            debugPrint('Profile: ${value.name}'),
          });
    });

    test('Get all profiles', () {
      final result = profilesRepository.getAllProfiles();

      result.listen((event) {
        expect(event, isNotNull);
        expect(event.length, 1);
        expect(event[0].name, profile1.name);
        expect(event[0].id, profile1.id);
        expect(event[0].balance, profile1.balance);
        expect(event[0].currency, profile1.currency);
        debugPrint('Profile: ${event[0].name}');
      });
    });

    group('Balance', () {
      test('Get profile balance', () async {
        final result = await profilesRepository.getBalance(1);

        debugPrint('Balance: $result');

        expect(profile1.balance, result);
      });

      test('Update balance: + 100500', () async {
        final result =
            await profilesRepository.updateBalance(1, profile1.balance);

        expect(1, result);

        final getBalance = await profilesRepository.getBalance(1);

        expect(profile1.balance, getBalance);
      });
    });
  });
}
