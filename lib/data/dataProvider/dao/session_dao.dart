import 'package:fin_control/data/dataProvider/database_manager.dart';
import 'dart:developer' as developer;

import 'package:fin_control/data/models/session.dart';

class SessionDao {
  final DatabaseManager databaseManager;
  final _columnName = 'sessions';

  SessionDao(this.databaseManager);

  Future<int> insertSession(Session session) async {
    final database = await databaseManager.initializeDB();

    try {
      return await database.rawInsert(
          'INSERT INTO sessions (id, profileId) VALUES (?, ?)',
          [session.id, session.profileId]);
    } catch (e) {
      developer.log('Error inserting rows: $e', time: DateTime.now());
      return 0;
    }
  }

  Stream<Session> getSession() async* {
    final database = await databaseManager.initializeDB();

    try {
      final result =
          await database.query(_columnName, columns: ['id', 'profileId']);
      final session = Session.fromMap(result.first);
      yield* Stream.value(session);
    } catch (e) {
      developer.log('Error getting session: $e', time: DateTime.now());
      yield* Stream.empty();
    }
  }

  Future<int> deleteSessions() async {
    final database = await databaseManager.initializeDB();

    try {
      return await database.delete(_columnName);
    } catch (e) {
      developer.log('Error deleting session: $e', time: DateTime.now());
      return 0;
    }
  }
}
