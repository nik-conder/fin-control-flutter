part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class LoadProfileEvent extends ProfileEvent {
  final int id;
  LoadProfileEvent(this.id);
}

class UpdateProfileNameEvent extends ProfileEvent {
  final String name;
  UpdateProfileNameEvent(this.name);
}

class CreateProfileEvent extends ProfileEvent {
  final String name;
  CreateProfileEvent({required this.name});
}
