import 'package:equatable/equatable.dart';
import 'package:fin_control/data/models/transaction.dart';

class TransactionsState extends Equatable {
  const TransactionsState({
    this.itemList,
    this.error,
    this.nextPageKey = 1,
  });

  final List<FinTransaction>? itemList;
  final dynamic error;
  final int? nextPageKey;

  @override
  List<Object?> get props => [];
}

class TransactionsErrorState extends TransactionsState {
  const TransactionsErrorState({super.error});
}

class TransactionsLoadedState extends TransactionsState {
  const TransactionsLoadedState({super.itemList, super.nextPageKey});
}

class TransactionDeleteErrorState extends TransactionsState {
  const TransactionDeleteErrorState({super.error});
}

class TransactionDeleteSuccessState extends TransactionsState {
  const TransactionDeleteSuccessState({super.itemList, super.nextPageKey});
}
