import 'dart:async';

import 'package:fin_control/data/models/profile.dart';
import 'package:fin_control/data/repository/profiles_repository.dart';
import 'package:fin_control/domain/bloc/profile/list/profile_list_event.dart';
import 'package:fin_control/domain/bloc/profile/list/profile_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stream_bloc/stream_bloc.dart';

class ProfileListBloc extends Bloc<ProfileListEvent, ProfileListState> {
  final ProfilesRepository _profilesRepository =
      GetIt.instance<ProfilesRepository>();

  final BehaviorSubject<List<Profile>> _profilesSubject =
      BehaviorSubject<List<Profile>>();

  Stream<List<Profile>> get profilesStream => _profilesSubject.stream;

  ProfileListBloc() : super(const ProfileListState(profiles: [])) {
    on<UpdateProfilesListEvent>(_updateProfilesList);
  }

  void _updateProfilesList(
      UpdateProfilesListEvent event, Emitter<ProfileListState> emit) {
    _profilesRepository.getAllProfiles().listen((profile) {
      _profilesSubject.add(profile);
    });
  }

  @override
  void dispose() {
    _profilesSubject.close();
  }
}
