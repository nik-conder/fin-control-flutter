import 'package:fin_control/config.dart';
import 'package:fin_control/data/models/transaction.dart';
import 'package:fin_control/data/repository/transactions_repository.dart';
import 'package:fin_control/domain/bloc/transactions/transactions_event.dart';
import 'package:fin_control/domain/bloc/transactions/transactions_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as dev;

import 'package:rxdart/rxdart.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  static const pageSize = TransactionsLimits.pageSize;

  final BehaviorSubject<List<FinTransaction>> _transactionsSubject =
      BehaviorSubject<List<FinTransaction>>();

  Stream<List<FinTransaction>> get transactionsStream =>
      _transactionsSubject.stream;

  final TransactionsRepository _transactionsRepository;

  TransactionsBloc(this._transactionsRepository)
      : super(const TransactionsState()) {
    on<TransactionAddEvent>(_addTransaction);
    on<TransactionDeleteEvent>(_deleteTransaction);
  }

  Future<List<FinTransaction>> fetchPage(int pageKey, int pageSize) async {
    final result =
        await _transactionsRepository.fetchAllTransactions(pageKey, pageSize);
    if (result == null) return [];
    return result;
  }

  _addTransaction(
      TransactionAddEvent event, Emitter<TransactionsState> emit) async {
    final result =
        await _transactionsRepository.insertTransaction(event.transaction);

    final getTrans = await _transactionsRepository.getTransaction(result);

    if (getTrans != null) {
      emit(const TransactionAddSuccessState());
      _transactionsSubject.sink.add([getTrans]);
    } else {
      emit(const TransactionAddErrorState());
    }

    dev.log("addTransaction", name: "TransactionsBloc");
  }

  _deleteTransaction(
      TransactionDeleteEvent event, Emitter<TransactionsState> emit) async {
    final result =
        await _transactionsRepository.deleteTransaction(event.transaction);
    if (result == 1) {
      emit(const TransactionDeleteSuccessState());
      dev.log("deleteTransaction", name: "TransactionsBloc");
    } else {
      emit(const TransactionDeleteErrorState());
      dev.log("deleteTransaction", name: "TransactionsBloc", error: "Error");
    }
  }

  void dispose() {
    _transactionsSubject.close();
  }
}
