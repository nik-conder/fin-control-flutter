import 'dart:async';
import 'dart:developer' as developer;
import 'package:fin_control/data/dataProvider/database_manager.dart';
import 'package:fin_control/data/models/profile.dart';

class ProfilesDAO {
  final DatabaseManager databaseManager;
  final _columnName = 'profiles';

  final StreamController<Profile> _profileChangesController =
      StreamController<Profile>.broadcast();

  ProfilesDAO(this.databaseManager);

  Future<int> insertProfile(Profile profile) async {
    final database = await databaseManager.initializeDB();

    try {
      final result = await database.rawInsert(
          'INSERT INTO profiles (id, name) VALUES (?, ?)',
          [profile.id, profile.name]);
      developer.log('Inserted Rows: $result', time: DateTime.now());
      return result;
    } catch (e) {
      developer.log('Error inserting rows: $e', time: DateTime.now());
      return 0;
    }
  }

  Future<String> getName(int id) async {
    final database = await databaseManager.initializeDB();

    try {
      final result =
          await database.query(_columnName, where: 'id = ?', whereArgs: [id]);
      return result.first['name'].toString();
    } catch (e) {
      developer.log('Error getting name: $e', time: DateTime.now());
      return 'Unknown';
    }
  }

  // Метод для получения потока изменений для конкретного профиля
  Stream<Profile> getProfile(int id) {
    return _profileChangesController.stream
        .where((profile) => profile.id == id);
  }
}
