import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

abstract class DatabaseManager {
  Future<Database> initializeDB();
}

class SQLiteDatabase implements DatabaseManager {
  final String _databaseName;
  final int _version;

  SQLiteDatabase()
      : _databaseName = 'fincontrolapp.db',
        _version = 1;

  @override
  Future<Database> initializeDB() async {
    // Initialize the database factory
    databaseFactory = databaseFactoryFfi;

    String path = await getDatabasesPath();

    Database database = await openDatabase(
      join(path, _databaseName),
      onCreate: (database, version) async {
        await database.execute(
          " CREATE TABLE IF NOT EXISTS settings(id INTEGER PRIMARY KEY AUTOINCREMENT, isDarkMode INTEGER NOT NULL)",
        );
      },
      version: _version,
    );

    return database;
  }
}
