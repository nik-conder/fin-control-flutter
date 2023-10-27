import 'package:fin_control/data/dataProvider/dao/transactions_dao.dart';
import 'package:fin_control/data/models/transaction.dart';
import 'dart:developer' as developer;

class TransactionsRepository {
  final TransactionsDao transactionsDao;

  TransactionsRepository(this.transactionsDao);

  Future<int> insertTransaction(FinTransaction transaction) async {
    try {
      final result = await transactionsDao.insertTransaction(transaction);
      developer.log('Inserted Rows: $result', time: DateTime.now());
      return result;
    } catch (e) {
      developer.log('Error inserting transaction: $e', time: DateTime.now());
      return 0;
    }
  }

  Future<List<FinTransaction>?> fetchAllTransactions(
      int pageKey, int pageSize) async {
    try {
      final result =
          await transactionsDao.fetchAllTransactions(pageKey, pageSize);
      return result;
    } catch (e) {
      developer.log('Error getting transactions: $e', time: DateTime.now());
      return null;
    }
  }

  Future<int> deleteAllTransactions() async {
    try {
      final result = await transactionsDao.deleteAllTransactions();
      developer.log('Deleted Rows: $result', time: DateTime.now());
      return result;
    } catch (e) {
      developer.log('Error deleting transactions: $e', time: DateTime.now());
      return 0;
    }
  }

  Future<FinTransaction?> getTransaction(int id) async {
    try {
      final result = await transactionsDao.getTransaction(id);
      return result;
    } catch (e) {
      developer.log('Error getting transaction: $e', time: DateTime.now());
      return null;
    }
  }
}
