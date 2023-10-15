import 'package:equatable/equatable.dart';
import 'package:fin_control/data/models/profile.dart';

class ProfileListState extends Equatable {
  final List<Profile>? profiles;

  const ProfileListState({required this.profiles});

  ProfileListState copyWith({
    List<Profile>? profiles,
  }) {
    return ProfileListState(
      profiles: profiles ?? this.profiles,
    );
  }

  @override
  List<Object?> get props => [profiles];
}
