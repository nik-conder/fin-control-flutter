import 'package:fin_control/data/dataProvider/database_manager.dart';
import 'dart:developer' as developer;

import 'package:fin_control/data/models/session.dart';

class SessionDao {
  final DatabaseManager databaseManager;
  final _columnName = 'sessions';

  SessionDao(this.databaseManager);

  Future<int> insertSession(Session session) async {
    try {
      final database = await databaseManager.initializeDB();
      final result = await database.rawInsert(
          'INSERT INTO $_columnName (id, profileId) VALUES (?, ?)',
          [session.id, session.profileId]);
      developer.log('Inserted Rows: $result', time: DateTime.now());
      return result;
    } catch (e) {
      developer.log('Error inserting rows: $e', time: DateTime.now());
      return 0;
    }
  }

  Future<Session?> getSession() async {
    try {
      final database = await databaseManager.initializeDB();
      final result =
          await database.query(_columnName, columns: ['id', 'profileId']);
      final session = Session.fromMap(result.first);
      return session;
    } catch (e) {
      developer.log('Error getting session: $e', time: DateTime.now());
      return null;
    }
  }

  Future<int> deleteSessions() async {
    final database = await databaseManager.initializeDB();

    try {
      final result = await database.delete(_columnName);
      developer.log('Deleted Rows: $result', time: DateTime.now());
      return result;
    } catch (e) {
      developer.log('Error deleting session: $e', time: DateTime.now());
      return 0;
    }
  }
}
