class AccountDto {
  final String id;
  final String name;
  final String type;
  final DateTime openedDate;
  final DateTime? closedDate;

  AccountDto({
    required this.id,
    required this.name,
    required this.type,
    required this.openedDate,
    this.closedDate,
  });

  factory AccountDto.fromJson(Map<String, dynamic> json) {
    return AccountDto(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      openedDate: DateTime.parse(
          json['openedDate'] as String),
      closedDate: json['closedDate'] != null
          ? DateTime.parse(json['closedDate'] as String)
          : null,
    );
  }
}
