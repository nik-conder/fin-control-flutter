import 'package:decimal/decimal.dart';

enum TransactionType { income, expense }

class FinTransaction {
  final int? id;
  final int profileId;
  final TransactionType type;
  final Decimal amount;
  final DateTime datetime;
  final String category;
  final String? note;

  FinTransaction({
    this.id,
    required this.profileId,
    required this.type,
    required this.amount,
    required this.datetime,
    required this.category,
    this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'profileId': profileId,
      'type': type == TransactionType.income ? 'income' : 'expense',
      'amount': amount.toDouble(),
      'datetime': datetime.toIso8601String(),
      'category': category,
      'note': (note == null || note!.isEmpty || note == '') ? null : note,
    };
  }

  factory FinTransaction.fromMap(Map<String, dynamic> map) {
    return FinTransaction(
      id: map['id'],
      profileId: map['profileId'],
      type: map['type'] == 'income'
          ? TransactionType.income
          : TransactionType.expense,
      amount: Decimal.parse(map['amount'].toString()),
      datetime: DateTime.parse(map['datetime'].toString()),
      category: map['category'].toString(),
      note: (map['note'] == null || map['note'].isEmpty || map['note'] == '')
          ? null
          : map['note'].toString(),
    );
  }
}
