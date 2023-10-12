import 'package:equatable/equatable.dart';
import 'package:fin_control/data/models/profile.dart';

class ProfileListState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProfilesListInitial extends ProfileListState {}

class ProfilesListLoading extends ProfileListState {}

class ProfilesListLoaded extends ProfileListState {
  final List<Profile> users;

  ProfilesListLoaded(this.users);

  @override
  List<Object> get props => [users];
}

class ProfilesListError extends ProfileListState {
  final String message;

  ProfilesListError(this.message);

  @override
  List<Object> get props => [message];
}
