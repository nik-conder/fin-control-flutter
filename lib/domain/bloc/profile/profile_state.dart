part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoadSuccess extends ProfileState {
  final Profile profile;

  const ProfileLoadSuccess(this.profile);
}

@immutable
class ProfileLoaded extends ProfileState {
  final Profile profile;

  const ProfileLoaded(this.profile);

  @override
  List<Object?> get props => [profile];
}

class GetBalanceSuccess extends ProfileState {
  final double balance;

  const GetBalanceSuccess(this.balance);

  @override
  List<Object?> get props => [balance];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

class CreateProfileSuccess extends ProfileState {}

class CreateProfileError extends ProfileState {
  final String message;

  const CreateProfileError(this.message);

  @override
  List<Object?> get props => [message];
}
