import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io' show Platform;

abstract class DatabaseManager {
  Future<Database> initializeDB();
  void close();
}

class SQLiteDatabase implements DatabaseManager {
  late DatabaseFactory databaseFactory;
  late Database db;

  late String dbPath;

  final int version = 2;

  final String nameDB = 'fin_control_app.db';

  final String _tableSettings =
      'CREATE TABLE IF NOT EXISTS settings(id INTEGER PRIMARY KEY AUTOINCREMENT, isDarkMode INTEGER NOT NULL)';

  final String _tableProfiles =
      'CREATE TABLE IF NOT EXISTS profiles(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, balance REAL DEFAULT 0, currency TEXT NOT NULL)';

  final String _tableSessions =
      'CREATE TABLE IF NOT EXISTS sessions(id INTEGER PRIMARY KEY AUTOINCREMENT, profileId INTEGER NOT NULL)';

  final String _tableTransactions =
      'CREATE TABLE transactions (id INTEGER PRIMARY KEY AUTOINCREMENT,profileId INTEGER,type TEXT,amount NUMERIC,datetime TEXT,category TEXT,note TEXT)';

  SQLiteDatabase() : super() {
    databaseFactory = databaseFactoryFfi;
  }

  @override
  Future<Database> initializeDB() async {
    if (Platform.isWindows || Platform.isLinux) {
      // Initialize FFI
      sqfliteFfiInit();
    }

    dbPath = await _getDBPath();

    // If current mode is debug, use inMemoryDatabasePath
    if (kDebugMode) {
      db = await databaseFactory.openDatabase(inMemoryDatabasePath,
          options: OpenDatabaseOptions(
            version: version,
            onCreate: (db, version) {
              db.execute(_tableSettings);
              db.execute(_tableProfiles);
              db.execute(_tableSessions);
              db.execute(_tableTransactions);
            },
          ));
    } else {
      db = await databaseFactory.openDatabase('$dbPath/$nameDB',
          options: OpenDatabaseOptions(
            version: version,
            onCreate: (db, version) {
              db.execute(_tableSettings);
              db.execute(_tableProfiles);
              db.execute(_tableSessions);
              db.execute(_tableTransactions);
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

  Future<String> _getDBPath() async {
    if (Platform.isWindows || Platform.isLinux) {
      return await databaseFactory.getDatabasesPath();
    } else {
      return await getDatabasesPath();
    }
  }

  @override
  void close() {
    db.close();
  }
}
