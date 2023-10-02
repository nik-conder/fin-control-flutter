import 'package:fin_control/data/dataProvider/DatabaseManager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
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

    test('initializeDB() should create the settings table', () async {
      final db = await database.initializeDB();

      // Проверяем, что база данных создана
      expect(db, isNotNull);

      // Проверяем, что таблица settings существует
      final tables = await db.query("sqlite_master",
          where: "type = 'table' AND name = 'settings'");
      expect(tables.isNotEmpty, true);

      // Проверяем, что структура таблицы правильная
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
