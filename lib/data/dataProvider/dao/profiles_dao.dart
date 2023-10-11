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

  // Stream<List<Profile>> getAllProfiles() async* {
  //   final database = databaseManager.initializeDB();
  //   try {
  //     final profiles = await _getProfiles();
  //     // Добавляем список профилей в поток
  //     streamControllerProfiles.add(profiles);

  //     developer.log('Profiles list:', time: DateTime.now(), error: profiles);
  //     // Завершаем поток
  //     streamControllerProfiles.close();
  //   } catch (e) {
  //     // Если произошла ошибка, передаем ошибку в поток
  //     streamControllerProfiles.addError(e);
  //     developer.log('Profile list:', time: DateTime.now(), error: e);
  //   }
  // }

  // Stream<List<Profile>> getAllProfiles() async* {
  //   final database = await databaseManager.initializeDB();

  //   try {
  //     final profiles = await _getProfiles();
  //     yield* profiles;
  //   } catch (e) {
  //     yield* Stream.error(e);
  //   }
  // }

  Stream<List<Profile>> getAllProfiles() async* {
    final db =
        await databaseManager.initializeDB(); // Получаем экземпляр базы данных

    final List<Map<String, dynamic>> maps =
        await db.query('profiles'); // Выполняем запрос к таблице 'profiles'

    // Преобразуем результат запроса в список объектов Profile
    final profiles = List.generate(maps.length, (i) {
      return Profile(
        // Здесь вы должны указать соответствующие поля и значения для вашего профиля
        id: maps[i]['id'],
        name: maps[i]['name'],
        // ...
      );
    });

    print(profiles);

    yield* Stream.value(profiles); // Отправляем список профилей через Stream

    // Закрываем Stream после отправки всех профилей
    yield* const Stream.empty();
  }
}
