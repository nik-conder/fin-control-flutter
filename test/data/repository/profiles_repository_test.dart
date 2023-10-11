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

    late ProfilesRepository profilesRepository;

    setUp(() {
      DependencyInjector.setup();
      profilesRepository = getIt<ProfilesRepository>();
    });

    test('Insert Profile', () async {
      final profile = Profile(id: 1, name: profileName);

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
        debugPrint('Profile: ${event[0].name}');
      });
    });

    tearDown(() {
      getIt.reset();
    });
  });
}
