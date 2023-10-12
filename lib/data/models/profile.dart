class Profile {
  int? id;
  final String name;
  double balance = 0;

  Profile({
    this.id,
    required this.name,
    this.balance = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'balance': balance,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      id: map['id'],
      name: map['name'],
      balance: map['balance'],
    );
  }
}
