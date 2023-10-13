import 'package:equatable/equatable.dart';
import 'package:fin_control/data/models/profile.dart';

abstract class ProfileListState extends Equatable {
  const ProfileListState();

  @override
  List<Object> get props => [];
}

class ProfileListLoading extends ProfileListState {}

class ProfileListLoaded extends ProfileListState {
  final List<Profile> profiles;

  const ProfileListLoaded({
    required this.profiles,
  });

  ProfileListLoaded copyWith({
    List<Profile>? profiles,
  }) {
    return ProfileListLoaded(
      profiles: profiles ?? this.profiles,
    );
  }

  @override
  List<Object> get props => [profiles];
}

class ProfileListError extends ProfileListState {
  final String message;

  const ProfileListError(this.message);

  @override
  ProfileListError copyWith() {
    return ProfileListError(message);
  }

  @override
  List<Object> get props => [message];
}

class ProfileSelected extends ProfileListState {
  final Profile profile;

  const ProfileSelected({required this.profile});

  @override
  ProfileSelected copyWith() {
    return ProfileSelected(profile: profile);
  }

  @override
  List<Object> get props => [profile];
}
