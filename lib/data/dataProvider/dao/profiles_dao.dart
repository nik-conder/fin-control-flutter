import 'dart:async';
import 'dart:developer' as developer;
import 'package:fin_control/data/dataProvider/database_manager.dart';
import 'package:fin_control/data/models/profile.dart';

class ProfilesDAO {
  final DatabaseManager databaseManager;
  final _columnName = 'profiles';

  ProfilesDAO(this.databaseManager);

  Future<int> insertProfile(Profile profile) async {
    final database = await databaseManager.initializeDB();

    try {
      return await database.rawInsert(
          'INSERT INTO profiles (id, name, balance) VALUES (?, ?, ?)',
          [profile.id, profile.name, profile.balance]);
    } catch (e) {
      developer.log('Error inserting rows: $e', time: DateTime.now());
      return 0;
    }
  }

  Future<String> getName(int id) async {
    final database = await databaseManager.initializeDB();

    try {
      final result = await database.query(_columnName,
          columns: ['name'], where: 'id = ?', whereArgs: [id]);
      return result.first['name'].toString();
    } catch (e) {
      developer.log('Error getting name: $e', time: DateTime.now());
      return 'Unknown';
    }
  }

  Stream<double> getBalance(int id) async* {
    final database = await databaseManager.initializeDB();

    try {
      final result = await database.query(
        _columnName,
        columns: ['balance'],
        where: 'id = ?',
        whereArgs: [id],
      );

      if (result.isNotEmpty) {
        final balance = result.first['balance'] as double;
        yield balance;
      } else {
        yield 0;
      }
    } catch (e) {
      developer.log('Error getting balance: $e', time: DateTime.now());
      yield 0;
    }
  }

  Future<Profile> getProfile(int id) async {
    final database = await databaseManager.initializeDB();
    try {
      final result =
          await database.query(_columnName, where: 'id = ?', whereArgs: [id]);
      if (result.isNotEmpty) {
        return Profile.fromMap(result.first);
      } else {
        return Profile(id: 0, name: 'Unknown');
      }
    } catch (e) {
      developer.log('Error getting name: $e', time: DateTime.now());
      return Profile(id: 0, name: 'Unknown');
    }
  }

  Future<num> updateBalance(int id, double balance) async {
    final database = await databaseManager.initializeDB();
    final getBalance = this.getBalance(id);

    try {
      final res = await database.rawUpdate(
        'UPDATE profiles SET balance = ? WHERE id = ?',
        [balance, id],
      );
      print('res: $res');
      return res;
    } catch (e) {
      developer.log('Error updating balance: $e', time: DateTime.now());
      return 0;
    }
  }

  Stream<List<Profile>> getAllProfiles() async* {
    try {
      final database = await databaseManager.initializeDB();
      final result = await database.query(_columnName);
      final profiles = List.generate(result.length, (i) {
        return Profile.fromMap(result[i]);
      });
      yield* Stream.value(profiles);
    } catch (e) {
      developer.log('Error getting all profiles: $e', time: DateTime.now());
      yield* Stream.error(e);
    }
  }
}

/*

 print("ebal");
    final db = await databaseManager.initializeDB();

    final List<Map<String, dynamic>> maps = await db.query('profiles');

    final profiles = List.generate(maps.length, (i) {
      return Profile(
        id: maps[i]['id'],
        name: maps[i]['name'],
        // ...
      );
    });

    yield* Stream.value(profiles);

    yield* const Stream.empty();

    */