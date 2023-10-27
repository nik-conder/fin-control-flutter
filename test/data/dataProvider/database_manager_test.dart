import 'package:fin_control/data/dataProvider/database_manager.dart';
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

    group("Table Settings", () {
      test('Check tables "settings"', () async {
        final db = await database.initializeDB();
        final tables = await db.query("sqlite_master",
            where: "type = 'table' AND name = 'settings'");
        expect(tables.isNotEmpty, true);
      });

      test('Check columns "settings"', () async {
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
    group("Table Profiles", () {
      test('Check tables "profiles"', () async {
        final db = await database.initializeDB();
        final tables = await db.query("sqlite_master",
            where: "type = 'table' AND name = 'profiles'");
        expect(tables.isNotEmpty, true);
      });

      test('Check columns "profiles"', () async {
        final db = await database.initializeDB();
        final result = await db.query('profiles');

        expect(result, isA<List<Map<String, dynamic>>>());

        if (result.isNotEmpty) {
          final columnNames = result[0].keys.toList();
          expect(columnNames.contains('id'), true);
          expect(columnNames.contains('name'), true);
        }
      });
    });

    group('Table Sessions', () {
      test('Check tables "sessions"', () async {
        final db = await database.initializeDB();
        final tables = await db.query("sqlite_master",
            where: "type = 'table' AND name = 'sessions'");
        expect(tables.isNotEmpty, true);
      });

      test('Check columns "sessions"', () async {
        final db = await database.initializeDB();
        final result = await db.query('sessions');
        if (result.isNotEmpty) {
          final columnNames = result[0].keys.toList();
          expect(columnNames.contains('id'), true);
          expect(columnNames.contains('profileId'), true);
        }
      });
    });

    group('Table Transactions', () {
      test('Check tables "transactions"', () async {
        final db = await database.initializeDB();
        final tables = await db.query("sqlite_master",
            where: "type = 'table' AND name = 'transactions'");
        expect(tables.isNotEmpty, true);
      });

      test('Check columns "transactions"', () async {
        final db = await database.initializeDB();
        final result = await db.query('transactions');
        if (result.isNotEmpty) {
          final columnNames = result[0].keys.toList();
          expect(columnNames.contains('id'), true);
          expect(columnNames.contains('profileId'), true);
          expect(columnNames.contains('type'), true);
          expect(columnNames.contains('amount'), true);
          expect(columnNames.contains('datetime'), true);
          expect(columnNames.contains('category'), true);
          expect(columnNames.contains('note'), true);
        }
      });
    });
  });
}
