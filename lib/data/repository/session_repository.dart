import 'package:fin_control/data/dataProvider/dao/session_dao.dart';
import 'package:fin_control/data/models/session.dart';
import 'dart:developer' as developer;

class SessionRepository {
  final SessionDao sessionDao;

  SessionRepository(this.sessionDao);

  Future<int> insertSession(Session session) async {
    try {
      return await sessionDao.insertSession(session);
    } catch (e) {
      developer.log('Error inserting rows: $e', time: DateTime.now());
      return 0;
    }
  }

  Stream<Session> getSession() async* {
    try {
      final result = await sessionDao.getSession();
      yield* result;
    } catch (e) {
      developer.log('Error getting session: $e', time: DateTime.now());
      yield* Stream.empty();
    }
  }

  Future<int> deleteSessions() async {
    try {
      return await sessionDao.deleteSessions();
    } catch (e) {
      developer.log('Error deleting session: $e', time: DateTime.now());
      return 0;
    }
  }
}
