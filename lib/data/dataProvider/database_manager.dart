import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

abstract class DatabaseManager {
  Future<Database> initializeDB();
  void close();
}

class SQLiteDatabase implements DatabaseManager {
  late DatabaseFactory databaseFactory;
  late Database db;

  late String dbPath;

  final int version = 1;

  final String _tableSettings =
      'CREATE TABLE IF NOT EXISTS settings(id INTEGER PRIMARY KEY AUTOINCREMENT, isDarkMode INTEGER NOT NULL)';

  final String _tableProfiles =
      'CREATE TABLE IF NOT EXISTS profiles(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, balance REAL DEFAULT 0)';

  final String _tableSessions =
      'CREATE TABLE IF NOT EXISTS sessions(id INTEGER PRIMARY KEY AUTOINCREMENT, profileId INTEGER NOT NULL)';

  SQLiteDatabase() : super() {
    databaseFactory = databaseFactoryFfi;
  }

  @override
  Future<Database> initializeDB() async {
    sqfliteFfiInit();

// Проверяем текущий режим работы приложения
    if (kDebugMode) {
      // Режим отладки: используем inMemoryDatabasePath
      db = await databaseFactory.openDatabase(inMemoryDatabasePath,
          options: OpenDatabaseOptions(
            version: 1,
            onCreate: (db, version) {
              db.execute(_tableSettings);
              db.execute(_tableProfiles);
              db.execute(_tableSessions);
            },
          ));
    } else {
      // Режим тестирования: используем временный путь к базе данных
      final dbPath = await databaseFactory.getDatabasesPath();
      db = await databaseFactory.openDatabase('$dbPath/my_database.db',
          options: OpenDatabaseOptions(
            version: 1,
            onCreate: (db, version) {
              db.execute(_tableSettings);
              db.execute(_tableProfiles);
              db.execute(_tableSessions);
            },
          ));
    }

    db.rawInsert("INSERT INTO settings (isDarkMode) VALUES (?)", [0]);
    return db;
  }

  @override
  void close() {
    db.close();
  }
}
