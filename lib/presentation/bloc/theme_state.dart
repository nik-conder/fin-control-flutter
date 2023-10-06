import 'package:equatable/equatable.dart';

class ThemeState extends Equatable {
  const ThemeState({
    this.isDarkMode = false,
  });

  final bool isDarkMode;

  ThemeState copyWith({
    bool? isDarkMode,
  }) {
    return ThemeState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }

  @override
  List<Object> get props => [isDarkMode];
}
