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

  final String nameDB = 'fin_control_app.db';

  final bool memoryDatabasePath =
      false; // flag to use inMemoryDatabasePath, flags: kDebugMode or true

  final String _tableSettings =
      'CREATE TABLE IF NOT EXISTS settings(id INTEGER PRIMARY KEY AUTOINCREMENT, isDarkMode INTEGER NOT NULL)';

  final String _tableProfiles =
      'CREATE TABLE IF NOT EXISTS profiles(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, balance REAL DEFAULT 0, currency TEXT NOT NULL)';

  final String _tableSessions =
      'CREATE TABLE IF NOT EXISTS sessions(id INTEGER PRIMARY KEY AUTOINCREMENT, profileId INTEGER NOT NULL)';

  SQLiteDatabase() : super() {
    databaseFactory = databaseFactoryFfi;
  }

  @override
  Future<Database> initializeDB() async {
    sqfliteFfiInit();

    // If current mode is debug, use inMemoryDatabasePath
    if (kDebugMode) {
      db = await databaseFactory.openDatabase(inMemoryDatabasePath,
          options: OpenDatabaseOptions(
            version: version,
            onCreate: (db, version) {
              db.execute(_tableSettings);
              db.execute(_tableProfiles);
              db.execute(_tableSessions);
            },
          ));
    } else {
      final dbPath = await databaseFactory.getDatabasesPath();
      db = await databaseFactory.openDatabase('$dbPath/$nameDB',
          options: OpenDatabaseOptions(
            version: version,
            onCreate: (db, version) {
              db.execute(_tableSettings);
              db.execute(_tableProfiles);
              db.execute(_tableSessions);
            },
          ));
    }

    // chek created settings row
    final settings = await db.query('settings');
    if (settings.isEmpty) {
      db.rawInsert("INSERT INTO settings (isDarkMode) VALUES (?)", [0]);
    }

    return db;
  }

  @override
  void close() {
    db.close();
  }
}
