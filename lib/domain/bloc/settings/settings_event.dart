part of 'settings_bloc.dart';

abstract class SettingsEvent {}

class GetDarkModeEvent extends SettingsEvent {}

class HideBalanceEvent extends SettingsEvent {}

class GetToken extends SettingsEvent {}

class SaveToken extends SettingsEvent {
  String value;

  SaveToken(this.value);
}
