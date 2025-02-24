import 'package:fin_control/data/models/session.dart';
import 'package:fin_control/data/repository/session_repository.dart';
import 'package:fin_control/core/dependency_injector.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

void main() {
  group('SessionRepository Tests', () {
    GetIt getIt = GetIt.instance;

    late SessionRepository sessionRepository;

    final Session session1 = Session(id: 1, profileId: 1);

    setUpAll(() {
      DependencyInjector.setup();
    });

    setUp(() {
      sessionRepository = getIt<SessionRepository>();
    });

    tearDownAll(() => getIt.reset());

    test('Insert Session', () async {
      final insertedRows = await sessionRepository.insertSession(session1);

      expect(1, insertedRows);
    });

    test('Get session', () async {
      final result = await sessionRepository.getSession();
      if (result != null) {
        expect(result.id, session1.id);
        expect(result.profileId, session1.profileId);
      } else {
        fail('Session is null');
      }
    });

    test('Delete all sessions', () async {
      // Create 10 sessions
      for (int i = 0; i < 10; i++) {
        await sessionRepository.insertSession(Session(id: i, profileId: i));
      }

      // Delete all sessions
      final result = await sessionRepository.deleteSessions();

      // Check if all sessions were deleted
      expect(result, 10);

      // Check if session was deleted
      final result2 = await sessionRepository.getSession();

      if (result2 != null) fail('Session is not null');
    });
  });
}
