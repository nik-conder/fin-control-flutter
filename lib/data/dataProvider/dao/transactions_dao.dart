import 'package:fin_control/data/dataProvider/database_manager.dart';
import 'package:fin_control/data/models/transaction.dart';
import 'dart:developer' as developer;

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class TransactionsDao {
  final DatabaseManager databaseManager;
  final _columnName = 'transactions';

  TransactionsDao(this.databaseManager);

  Future<int> insertTransaction(FinTransaction transaction) async {
    try {
      final database = await databaseManager.initializeDB();
      final result = await database.insert(
        _columnName,
        transaction.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      developer.log('Inserted Rows: $result', time: DateTime.now());
      return result;
    } catch (e) {
      developer.log('',
          time: DateTime.now(), error: 'Error inserting transaction');
      return 0;
    }
  }

  Future<FinTransaction?> getTransaction(int id) async {
    try {
      final database = await databaseManager.initializeDB();
      final result = await database.query(
        _columnName,
        where: 'id = ?',
        whereArgs: [id],
      );

      final transaction = FinTransaction.fromMap(result.first);
      return transaction;
    } catch (e) {
      developer.log('Error getting transaction: $e', time: DateTime.now());
      return null;
    }
  }

  Future<List<FinTransaction>?> fetchAllTransactions(
      int pageKey, int pageSize) async {
    try {
      final database = await databaseManager.initializeDB();
      final result = await database.query(
        _columnName,
        limit: pageSize,
        offset: pageKey,
      );

      final transactions = List.generate(result.length, (i) {
        return FinTransaction.fromMap(result[i]);
      });
      return transactions;
    } catch (e) {
      developer.log('Error getting transactions: $e', time: DateTime.now());
      return null;
    }
  }

  Future<int> deleteAllTransactions() async {
    try {
      final database = await databaseManager.initializeDB();
      final result = await database.delete(_columnName);
      developer.log('Deleted Rows: $result', time: DateTime.now());
      return result;
    } catch (e) {
      developer.log('Error deleting transactions: $e', time: DateTime.now());
      return 0;
    }
  }
}
