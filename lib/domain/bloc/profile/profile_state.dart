part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class LoginProfileSuccess extends ProfileState {
  final Profile profile;

  const LoginProfileSuccess(this.profile);
}

class LoginProfileError extends ProfileState {}

class LoginProfileEmpty extends ProfileState {}

class ListProfilesLoading extends ProfileState {}

class ListProfilesSuccess extends ProfileState {
  final List<Profile> profiles;

  const ListProfilesSuccess(this.profiles);
}

class ListProfilesError extends ProfileState {}

class CreateProfileSuccess extends ProfileState {}

class CreateProfileError extends ProfileState {
  final ProfileNameMsg message;

  const CreateProfileError(this.message);

  @override
  List<Object?> get props => [message];
}
