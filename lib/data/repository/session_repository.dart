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

  Future<Session?> getSession() async {
    return await sessionDao.getSession();
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
