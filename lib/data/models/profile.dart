import 'package:fin_control/data/models/currency.dart';

class Profile {
  int? id;
  final String name;
  double balance = 0;
  Currency currency;

  Profile({
    this.id,
    required this.name,
    this.balance = 0,
    required this.currency,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'balance': balance,
      'currency': currency.name
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      id: map['id'],
      name: map['name'],
      balance: map['balance'],
      currency: Currency.values.firstWhere(
        (element) => element.name == map['currency'],
        orElse: () => Currency.usd,
      ),
    );
  }
}
