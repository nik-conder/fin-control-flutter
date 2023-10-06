import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DBFactory {
  static void setup() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
}
