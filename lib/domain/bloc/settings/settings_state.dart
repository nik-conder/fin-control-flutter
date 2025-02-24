part of 'settings_bloc.dart';

final class SettingsState extends Equatable {
  const SettingsState(
      {this.isDarkMode = false, this.hideBalance = false, this.token = ''});

  final bool isDarkMode;
  final bool hideBalance;
  final String token;

  SettingsState copyWith({bool? isDarkMode, bool? hideBalance, String? token}) {
    return SettingsState(
        isDarkMode: isDarkMode ?? this.isDarkMode,
        hideBalance: hideBalance ?? this.hideBalance,
        token: token ?? this.token);
  }

  @override
  List<Object> get props => [isDarkMode, hideBalance, token];
}
