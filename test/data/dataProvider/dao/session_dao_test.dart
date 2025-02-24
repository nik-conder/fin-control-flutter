import 'package:fin_control/data/dataProvider/dao/session_dao.dart';
import 'package:fin_control/data/models/session.dart';
import 'package:fin_control/core/dependency_injector.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

void main() {
  group('SessionDao Tests', () {
    final getIt = GetIt.instance;

    final Session session1 = Session(id: 1, profileId: 1);

    late SessionDao sessionDao;

    setUpAll(() {
      DependencyInjector.setup();
    });

    setUp(() {
      sessionDao = getIt<SessionDao>();
    });

    tearDownAll(() {
      getIt.reset();
    });

    test('Insert Session', () async {
      final insertedRows = await sessionDao.insertSession(session1);

      expect(1, insertedRows);
    });

    test('Get session', () async {
      final result = await sessionDao.getSession();

      expect(result, isA<Session>());

      if (result != null) {
        expect(session1.id, result.id);
        expect(session1.profileId, result.profileId);
      } else {
        fail('Session is null');
      }
    });

    test('Delete all sessions', () async {
      // Create 10 sessions
      for (int i = 0; i < 10; i++) {
        await sessionDao.insertSession(Session(id: i, profileId: i));
      }

      // Delete all sessions
      final result = await sessionDao.deleteSessions();

      // Check if all sessions were deleted
      expect(result, 10);
    });
  });
}
