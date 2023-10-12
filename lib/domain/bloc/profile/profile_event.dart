import 'package:fin_control/data/models/profile.dart';

abstract class ProfileEvent {}

class LoadProfiles extends ProfileEvent {
  LoadProfiles(this.users);

  final List<Profile> users;
}

class CreateProfileEvent extends ProfileEvent {
  final String name;

  CreateProfileEvent(this.name);

  @override
  List<Object?> get props => [name];
}

class GetBalanceEvent extends ProfileEvent {
  GetBalanceEvent(this.id);

  final int id;

  @override
  List<Object?> get props => [id];
}

class UpdateBalance extends ProfileEvent {
  final int id;
  final double balance;

  UpdateBalance(this.id, this.balance);
}
