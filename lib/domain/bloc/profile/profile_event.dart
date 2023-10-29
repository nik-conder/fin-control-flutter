import 'package:fin_control/data/models/currency.dart';
import 'package:fin_control/data/models/profile.dart';

abstract class ProfileEvent {}

class LoadProfiles extends ProfileEvent {
  LoadProfiles(this.users);

  final List<Profile> users;
}

class CreateProfileEvent extends ProfileEvent {
  final String name;
  final Currency currency;

  CreateProfileEvent(this.name, this.currency);

  List<Object?> get props => [name, currency];
}

class CreateDemoProfileEvent extends ProfileEvent {}

class GetBalanceEvent extends ProfileEvent {
  GetBalanceEvent(this.id);

  final int id;

  List<Object?> get props => [id];
}

class UpdateBalance extends ProfileEvent {}

class ChangeBalance extends ProfileEvent {
  final int id;
  final double balance;

  ChangeBalance(this.id, this.balance);
}

class UpdateProfilesListEvent extends ProfileEvent {}
