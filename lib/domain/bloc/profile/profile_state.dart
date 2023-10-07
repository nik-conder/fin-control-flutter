part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final int id;
  final String name;

  const ProfileState({
    required this.id,
    required this.name,
  });

  ProfileState copyWith({
    int? id,
    String? name,
  }) {
    return ProfileState(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  List<Object> get props => [id, name];
}
