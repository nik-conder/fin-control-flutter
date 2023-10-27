import 'package:decimal/decimal.dart';
import 'package:fin_control/config.dart';
import 'package:fin_control/data/models/transaction.dart';
import 'package:fin_control/data/repository/transactions_repository.dart';
import 'package:fin_control/dependency_injector.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

void main() {
  group('TransactionsRepository Tests', () {
    final getIt = GetIt.instance;
    late TransactionsRepository transactionsRepository;
    const pageSize = TransactionsLimits.pageSize;

    final FinTransaction transaction1 = FinTransaction(
      profileId: 1,
      type: TransactionType.income,
      amount: Decimal.parse('100'),
      datetime: DateTime.now(),
      category: 'category',
      note: 'note',
    );

    setUpAll(() => DependencyInjector.setup());

    setUp(() => {
          transactionsRepository = getIt<TransactionsRepository>(),
        });

    tearDownAll(() => getIt.reset());

    test('Check Insert Transaction', () async {
      final int insertedRows =
          await transactionsRepository.insertTransaction(transaction1);

      expect(1, insertedRows);
    });

    test('Check insert {pageSize} transactions', () async {
      try {
        for (var i = 0; i < pageSize - 1; i++) {
          final insertResult =
              await transactionsRepository.insertTransaction(FinTransaction(
            profileId: 1,
            type: TransactionType.income,
            amount: Decimal.parse('100'),
            datetime: DateTime.now(),
            category: 'category',
            note: 'note',
          ));
          expect(i + 2, insertResult);
        }
      } catch (e) {
        fail(e.toString());
      }
    });

    test('Get all transactions', () async {
      try {
        final result = await transactionsRepository.fetchAllTransactions(
            1, TransactionsLimits.pageSize);

        if (result == null) fail('No transactions found');

        expect(pageSize - 1, result.length);
      } catch (e) {
        fail(e.toString());
      }
    });

    test('Get transaction by id', () async {
      final result = await transactionsRepository.getTransaction(1);

      if (result == null) fail('No transaction found');
      expect(transaction1.profileId, result.profileId);
      expect(transaction1.type, result.type);
      expect(transaction1.amount, result.amount);
      expect(transaction1.datetime, result.datetime);
      expect(transaction1.category, result.category);
      expect(transaction1.note, result.note);
    });
  });
}
