import 'package:fin_control/data/models/profile.dart';

abstract class ProfileListEvent {}

class LoadProfiles extends ProfileListEvent {}

class SelectProfile extends ProfileListEvent {
  final Profile profile;

  SelectProfile(this.profile);
}

class Login extends ProfileListEvent {
  final Profile profile;

  Login(this.profile);
}
