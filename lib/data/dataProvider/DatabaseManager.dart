import 'package:sqflite_common_ffi/sqflite_ffi.dart';

abstract class DatabaseManager {
  Future<Database> initializeDB();
}

class SQLiteDatabase implements DatabaseManager {
  final String _databaseName;

  SQLiteDatabase() : _databaseName = 'fincontrolapp.db';

  @override
  Future<Database> initializeDB() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    final db = await databaseFactory.openDatabase(inMemoryDatabasePath,
        options: OpenDatabaseOptions(
          version: 1,
          onCreate: (db, version) {
            db.execute(
              'CREATE TABLE IF NOT EXISTS settings(id INTEGER PRIMARY KEY AUTOINCREMENT, isDarkMode INTEGER NOT NULL)',
            );
          },
        ));

    // db.execute(
    //   'CREATE TABLE IF NOT EXISTS settings(id INTEGER PRIMARY KEY AUTOINCREMENT, isDarkMode INTEGER NOT NULL)',
    // );

    return db;
  }
}
