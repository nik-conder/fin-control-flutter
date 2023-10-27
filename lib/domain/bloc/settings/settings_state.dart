part of 'settings_bloc.dart';

final class SettingsState extends Equatable {
  const SettingsState({
    this.isDarkMode = false,
    this.hideBalance = false,
  });

  final bool isDarkMode;
  final bool hideBalance;

  SettingsState copyWith({
    bool? isDarkMode,
    bool? hideBalance,
  }) {
    return SettingsState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      hideBalance: hideBalance ?? this.hideBalance,
    );
  }

  @override
  List<Object> get props => [isDarkMode, hideBalance];
}
