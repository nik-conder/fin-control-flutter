import 'dart:async';

import 'package:fin_control/data/models/profile.dart';
import 'package:fin_control/data/repository/profiles_repository.dart';
import 'package:fin_control/domain/bloc/profile/list/profile_list_event.dart';
import 'package:fin_control/domain/bloc/profile/list/profile_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ProfileListBloc extends Bloc<ProfileListEvent, ProfileListState> {
  late Timer timer;
  final ProfilesRepository _profilesRepository =
      GetIt.instance<ProfilesRepository>();

  Stream<List<Profile>> get usersList async* {
    yield* _profilesRepository.getAllProfiles();
  }

  final StreamController<List<Profile>> _controller =
      StreamController<List<Profile>>();

  Stream<List<Profile>> get profileListStream => _controller.stream;

  ProfileListBloc() : super(ProfileListState()) {
    usersList.listen((list) async {
      await Future<void>.delayed(const Duration(seconds: 2));
      _controller.add(list);
    });

    timer = Timer.periodic(const Duration(seconds: 2), (Timer t) async {
      final profiles = _profilesRepository.getAllProfiles();
      profiles.listen((list) {
        _controller.add(list);
      });
    });
  }

  @override
  Future<void> close() {
    timer.cancel();
    _controller.close();
    return super.close();
  }
}
