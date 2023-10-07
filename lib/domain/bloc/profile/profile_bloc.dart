import 'dart:developer' as developer;

import 'package:fin_control/data/models/profile.dart';
import 'package:fin_control/data/repository/profiles_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfilesRepository _profilesRepository;

  ProfileBloc(this._profilesRepository)
      : super(const ProfileState(id: 0, name: '')) {
    on<CreateProfileEvent>(_createProfile);
    on<LoadProfileEvent>(_loadProfile);
    on<UpdateProfileNameEvent>(_updateProfileName);
  }

  Stream<int> mapEventToStates(ProfileEvent event) async* {
    if (event is LoadProfileEvent) {}
  }

  _loadProfile(LoadProfileEvent event, Emitter<ProfileState> emit) {}

  _updateProfileName(
      UpdateProfileNameEvent event, Emitter<ProfileState> emit) {}

  _createProfile(CreateProfileEvent event, Emitter<ProfileState> emit) async {
    final result =
        await _profilesRepository.insertProfile(Profile(name: event.name));

    if (result == 1) {
      developer.log('всё ок', time: DateTime.now());
      developer.log('Inserted Rows: $result', time: DateTime.now());

      developer.log('click create profile ${event.name}', time: DateTime.now());

      emit(state.copyWith(name: event.name));
      developer.log('state: ${state.name}', time: DateTime.now());
    } else {
      developer.log('',
          time: DateTime.now(), error: 'Ошибка при создании профиля');
    }
  }

  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is LoadProfileEvent) {
      // Здесь можно загрузить профиль с сервера, используя event.id
      yield state.copyWith(id: event.id, name: 'Loaded Profile Name');
    } else if (event is UpdateProfileNameEvent) {
      yield state.copyWith(name: event.name);
    }
  }

  Stream<Profile> getProfileChanges(int id) {
    return _profilesRepository.getProfile(id);
  }
}
