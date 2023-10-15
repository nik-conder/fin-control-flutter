class Session {
  final int? id;
  final int profileId;

  Session({
    this.id,
    required this.profileId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'profileId': profileId,
    };
  }

  factory Session.fromMap(Map<String, dynamic> map) {
    return Session(
      id: map['id'],
      profileId: map['profileId'],
    );
  }
}
