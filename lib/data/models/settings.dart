class Settings {
  final int id;
  final int isDarkMode;

  Settings({
    required this.id,
    required this.isDarkMode,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'isDarkMode': isDarkMode,
    };
  }

  factory Settings.fromMap(Map<String, dynamic> map) {
    return Settings(
      id: map['id'],
      isDarkMode: map['isDarkMode'],
    );
  }
}
