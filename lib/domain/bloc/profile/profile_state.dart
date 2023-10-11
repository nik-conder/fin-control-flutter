part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfilesInitial extends ProfileState {}

class ProfilesLoading extends ProfileState {}

class ProfilesLoaded extends ProfileState {
  final List<Profile> users;

  const ProfilesLoaded(this.users);

  @override
  List<Object?> get props => [users];
}

class ProfilesTracking extends ProfileState {
  final List<Profile> users;

  const ProfilesTracking(this.users);

  @override
  List<Object?> get props => [users];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

class TextFieldNameState extends ProfileState {
  final String name;

  TextFieldNameState(this.name);
}

class CreateProfileSuccess extends ProfileState {}

class CreateProfileError extends ProfileState {
  final String message;

  CreateProfileError(this.message);

  @override
  List<Object?> get props => [message];
}
