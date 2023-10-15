import 'package:fin_control/data/models/session.dart';
import 'package:fin_control/data/repository/session_repository.dart';
import 'package:fin_control/dependency_injector.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

void main() {
  group('SessionRepository Tests', () {
    GetIt getIt = GetIt.instance;

    late SessionRepository sessionRepository;

    final Session session1 = Session(id: 1, profileId: 1);

    setUp(() => {
          DependencyInjector.setup(),
          sessionRepository = getIt<SessionRepository>()
        });

    test('Insert Session', () async {
      final insertedRows = await sessionRepository.insertSession(session1);

      expect(1, insertedRows);
    });

    test('Get session', () async {
      final result = await sessionRepository.getSession();
      result.listen((event) {
        expect(event, isA<Session>());

        expect(session1.id, event.id);
        expect(session1.profileId, event.profileId);
      });
    });

    test('Delete Session', () async {
      final result = await sessionRepository.deleteSessions();
      expect(result, 1);
    });
    tearDown(() => getIt.reset());
  });
}
