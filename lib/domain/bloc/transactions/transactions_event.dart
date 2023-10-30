import 'package:equatable/equatable.dart';
import 'package:fin_control/data/models/transaction.dart';

abstract class TransactionsEvent extends Equatable {}

class TransactionsInitial extends TransactionsEvent {
  @override
  List<Object?> get props => [];
}

class PageRequestEvent extends TransactionsEvent {
  final int pageKey;
  final int pageSize;

  PageRequestEvent(this.pageKey, this.pageSize);

  @override
  List<Object?> get props => [pageKey, pageSize];
}

class TransactionAddEvent extends TransactionsEvent {
  final FinTransaction transaction;

  TransactionAddEvent(this.transaction);

  @override
  List<Object?> get props => [transaction];
}

class TransactionDeleteEvent extends TransactionsEvent {
  final FinTransaction transaction;

  TransactionDeleteEvent(this.transaction);

  @override
  List<Object?> get props => throw UnimplementedError();
}
