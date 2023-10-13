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

  final BehaviorSubject<List<Profile>> _profileListSubject =
      BehaviorSubject<List<Profile>>();

  Stream<List<Profile>> get profileListStream => _profileListSubject.stream;

  ProfileListBloc() : super(ProfileListLoading()) {
    on<SelectProfile>(_selectProfile);
    on<Login>((event, emit) {
      print(event.profile.toMap());
    });

    _profilesRepository
        .getAllProfiles()
        .throttleTime(const Duration(seconds: 2))
        .listen((event) {
      print("emit all profiles: ${event.length}");
      _profileListSubject.add(event);
    });
  }

  _selectProfile(SelectProfile event, Emitter<ProfileListState> emit) async {
    print('clicked ${event.profile.name}');
    emit(ProfileSelected(profile: event.profile));
  }

  @override
  Future<void> close() {
    _profileListSubject.close();
    return super.close();
  }
}
