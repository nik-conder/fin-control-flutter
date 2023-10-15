import 'package:fin_control/data/dataProvider/dao/session_dao.dart';
import 'package:fin_control/data/models/session.dart';
import 'package:fin_control/dependency_injector.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

void main() {
  group('SessionDao Tests', () {
    final getIt = GetIt.instance;

    final Session session1 = Session(id: 1, profileId: 1);

    late SessionDao sessionDao;

    setUp(() {
      DependencyInjector.setup();
      sessionDao = getIt<SessionDao>();
    });

    test('Insert Session', () async {
      final insertedRows = await sessionDao.insertSession(session1);

      expect(insertedRows, 1);
    });

    test('Get session', () async {
      final result = await sessionDao.getSession();
      result.listen((event) {
        expect(event, isA<Session>());

        expect(session1.id, event.id);
        expect(session1.profileId, event.profileId);
      });
    });

    test('Delete Session', () async {
      final result = await sessionDao.deleteSessions();
      expect(result, 1);
    });

    tearDown(() => getIt.reset());
  });
}
