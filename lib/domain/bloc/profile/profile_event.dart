import 'package:fin_control/data/models/profile.dart';

abstract class ProfileEvent {}

class LoadProfiles extends ProfileEvent {
  LoadProfiles(this.users);

  final List<Profile> users;
}

class TextFieldNameEvent extends ProfileEvent {
  final String name;

  TextFieldNameEvent(this.name);

  @override
  List<Object?> get props => [name];
}

class CreateProfileEvent extends ProfileEvent {
  final String name;

  CreateProfileEvent(this.name);

  @override
  List<Object?> get props => [name];
}
