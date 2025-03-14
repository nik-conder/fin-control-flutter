import 'dart:async';
import 'dart:developer' as developer;
import 'package:fin_control/core/logger.dart';
import 'package:fin_control/data/dataProvider/database_manager.dart';
import 'package:fin_control/data/models/currency.dart';
import 'package:fin_control/data/models/profile.dart';

class ProfilesDAO {
  final DatabaseManager databaseManager;
  final _columnName = 'profiles';

  ProfilesDAO(this.databaseManager);

  Future<int> insertProfile(Profile profile) async {
    try {
      final database = await databaseManager.initializeDB();
      return await database.rawInsert(
          'INSERT INTO $_columnName (id, name, balance, currency) VALUES (?, ?, ?, ?)',
          [profile.id, profile.name, profile.balance, profile.currency.name]);
    } catch (e) {
      developer.log('Error inserting rows: $e', time: DateTime.now());
      return 0;
    }
  }

  Future<String> getName(int id) async {
    try {
      final database = await databaseManager.initializeDB();
      final result = await database.query(_columnName,
          columns: ['name'], where: 'id = ?', whereArgs: [id]);
      return result.first['name'].toString();
    } catch (e) {
      developer.log('Error getting name: $e', time: DateTime.now());
      return 'Unknown';
    }
  }

  Future<double> getBalance(int id) async {
    try {
      final database = await databaseManager.initializeDB();
      final result = await database.query(
        _columnName,
        columns: ['balance'],
        where: 'id = ?',
        whereArgs: [id],
      );

      if (result.isNotEmpty) {
        final balance = result.first['balance'] as double;
        return balance;
      } else {
        return 0;
      }
    } catch (e) {
      developer.log('Error getting balance: $e', time: DateTime.now());
      return 0;
    }
  }

  Future<Profile> getProfile(int id) async {
    try {
      final database = await databaseManager.initializeDB();
      final result =
          await database.query(_columnName, where: 'id = ?', whereArgs: [id]);

      return Profile.fromMap(result.first);
    } catch (e) {
      developer.log('Error getting profile: $e', time: DateTime.now());
      return Profile(id: 0, name: '', balance: 0, currency: Currency.usd);
    }
  }

  Future<int> updateBalance(int id, double balance) async {
    try {
      final database = await databaseManager.initializeDB();
      final res = await database.rawUpdate(
        'UPDATE profiles SET balance = ? WHERE id = ?',
        [balance, id],
      );
      return res;
    } catch (e) {
      developer.log('Error updating balance: $e', time: DateTime.now());
      return 0;
    }
  }

  Future<List<Profile>?> getAllProfiles() async {
    try {
      final database = await databaseManager.initializeDB();
      final result = await database.query(_columnName);
      final profiles = List.generate(result.length, (i) {
        return Profile.fromMap(result[i]);
      });
      return profiles;
    } catch (e) {
      developer.log('Error getting all profiles: $e', time: DateTime.now());
      return null;
    }
  }

  Future<bool> deleteProfile(Profile profile) async {
    try {
      final database = await databaseManager.initializeDB();
      final res = await database
          .delete(_columnName, where: 'id = ?', whereArgs: [profile.id]);
      return res > 0;
    } catch (e) {
      logger.e('Error deleting profile: $e', time: DateTime.now());
      return false;
    }
  }
}
