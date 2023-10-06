import 'package:fin_control/data/dataProvider/DatabaseManager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SQLiteDatabase', () {
    late SQLiteDatabase database;

    setUp(() {
      // Инициализация базы данных перед каждым тестом
      databaseFactory = databaseFactoryFfi;
      database = SQLiteDatabase();
    });

    test('Check db', () async {
      final db = await database.initializeDB();
      expect(db, isNotNull);
    });

    test('Check tables', () async {
      final db = await database.initializeDB();
      final tables = await db.query("sqlite_master",
          where: "type = 'table' AND name = 'settings'");
      expect(tables.isNotEmpty, true);
    });

    test('Check columns', () async {
      final db = await database.initializeDB();
      final result = await db.query('settings');

      expect(result, isA<List<Map<String, dynamic>>>());

      if (result.isNotEmpty) {
        final columnNames = result[0].keys.toList();
        expect(columnNames.contains('id'), true);
        expect(columnNames.contains('isDarkMode'), true);
      }
    });
  });
}
