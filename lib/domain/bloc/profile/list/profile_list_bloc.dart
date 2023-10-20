import 'dart:async';

import 'package:fin_control/data/models/profile.dart';
import 'package:fin_control/data/repository/profiles_repository.dart';
import 'package:fin_control/domain/bloc/profile/list/profile_list_event.dart';
import 'package:fin_control/domain/bloc/profile/list/profile_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class ProfileListBloc extends Bloc<ProfileListEvent, ProfileListState> {
  final ProfilesRepository _profilesRepository =
      GetIt.instance<ProfilesRepository>();

  final BehaviorSubject<List<Profile>> _profilesSubject =
      BehaviorSubject<List<Profile>>();

  Stream<List<Profile>> get profilesStream => _profilesSubject.stream;

  ProfileListBloc() : super(ProfileListInitial()) {
    on<UpdateProfilesListEvent>(_updateProfilesList);
  }

  _updateProfilesList(
      UpdateProfilesListEvent event, Emitter<ProfileListState> emit) async {
    final result = _profilesRepository.getAllProfiles();

    result.listen((event) {
      if (event.isNotEmpty) _profilesSubject.sink.add(event);
    }, onError: (error) {
      _profilesSubject.addError(error);
    });
  }

  void dispose() {
    _profilesSubject.close();
  }
}
