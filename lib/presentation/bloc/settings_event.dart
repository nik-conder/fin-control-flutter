part of 'settings_bloc.dart';

abstract class SettingsEvent {}

class DarkModeEvent extends SettingsEvent {
  final bool isDarkMode;
  DarkModeEvent({required this.isDarkMode});
}
