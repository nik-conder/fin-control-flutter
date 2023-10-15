import 'package:fin_control/data/models/profile.dart';

abstract class ProfileListEvent {}

class LoadProfilesEvent extends ProfileListEvent {}

class UpdateProfilesListEvent extends ProfileListEvent {}

class LoginEvent extends ProfileListEvent {
  final Profile profile;

  LoginEvent(this.profile);
}
