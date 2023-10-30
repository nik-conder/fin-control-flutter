import 'package:decimal/decimal.dart';
import 'package:fin_control/config.dart';
import 'package:fin_control/data/dataProvider/dao/transactions_dao.dart';
import 'package:fin_control/data/models/transaction.dart';
import 'package:fin_control/dependency_injector.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

void main() {
  group('TransactionsDao Tests', () {
    final getIt = GetIt.instance;

    late TransactionsDao transactionsDao;
    const pageSize = TransactionsLimits.pageSize;
    final datetime = DateTime.parse('2022-01-01 00:00:00');
    final FinTransaction transaction1 = FinTransaction(
      profileId: 1,
      type: TransactionType.income,
      amount: Decimal.parse('100'),
      datetime: datetime,
      category: 'category',
    );

    setUpAll(() => DependencyInjector.setup());

    setUp(() {
      transactionsDao = getIt<TransactionsDao>();
    });

    tearDownAll(() {
      getIt.reset();
    });

    test('Check Insert Transaction', () async {
      final int insertedRows =
          await transactionsDao.insertTransaction(transaction1);
      expect(1, insertedRows);
    });

    test('Get transaction by id', () async {
      final result = await transactionsDao.getTransaction(1);
      if (result == null) fail('No transaction found');
      expect(transaction1.profileId, result.profileId);
      expect(transaction1.type, result.type);
      expect(transaction1.amount, result.amount);
      expect(transaction1.datetime, result.datetime);
      expect(transaction1.category, result.category);
      expect(transaction1.note, result.note);
    });

    test('Check insert {pageSize} transactions', () async {
      try {
        for (var i = 0; i < pageSize - 1; i++) {
          final insertResult =
              await transactionsDao.insertTransaction(FinTransaction(
            profileId: 1,
            type: TransactionType.income,
            amount: Decimal.parse('100'),
            datetime: datetime,
            category: 'category',
          ));

          if (insertResult == 0) fail('Error inserting transaction');
        }
      } catch (e) {
        fail(e.toString());
      }
    });

    test('Get all transactions', () async {
      try {
        final result = await transactionsDao.fetchAllTransactions(1, pageSize);
        if (result == null) fail('No transactions found');

        for (var element in result) {
          expect(element.profileId, 1);
          expect(element.type, TransactionType.income);
          expect(element.amount, Decimal.parse('100'));
          expect(element.datetime, datetime);
          expect(element.category, 'category');
          expect(element.note, isNull);
        }
      } catch (e) {
        fail(e.toString());
      }
    });

    test("Delete transaction", () async {
      final transaction = FinTransaction(
        id: 100500,
        profileId: 1,
        type: TransactionType.income,
        amount: Decimal.parse('100'),
        datetime: datetime,
        category: 'category',
      );
      final result = await transactionsDao.insertTransaction(transaction);

      expect(100500, result);

      final deletedRows = await transactionsDao.deleteTransaction(transaction);
      expect(1, deletedRows);
    });

    test('Delete all transactions ', () async {
      final deletedRows = await transactionsDao.deleteAllTransactions();
      expect(20, deletedRows);
    });
  });
}
