part of 'settings_bloc.dart';

abstract class SettingsEvent {}

class SetDarkModeEvent extends SettingsEvent {
  final bool isDarkMode;
  SetDarkModeEvent({required this.isDarkMode});
}

class GetDarkModeEvent extends SettingsEvent {}
