import 'package:fin_control/core/logger.dart';
import 'package:fin_control/data/models/profile.dart';
import 'package:fin_control/data/repository/profiles_repository.dart';
import 'package:fin_control/domain/bloc/profile/profile_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../config.dart';
import '../../../data/repository/session_repository.dart';
import '../../../presentation/utils/sysmsg.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final SessionRepository _sessionRepository;
  final ProfilesRepository _profilesRepository;

  ProfileBloc(this._sessionRepository, this._profilesRepository)
      : super(ProfileInitial()) {
    on<GetListProfiles>(_getListProfiles);
    on<GetLoginProfile>(_getLoginProfile);
    on<CreateProfileEvent>(_createProfile);
    on<UpdateProfilesListEvent>(_updateProfilesList);
    on<DeleteProfile>(_deleteProfile);
  }

  void _getListProfiles(
      GetListProfiles event, Emitter<ProfileState> emit) async {
    emit(ListProfilesLoading());
    final listProfiles = await _profilesRepository.getAllProfiles();

    if (listProfiles!.isNotEmpty) {
      emit(ListProfilesSuccess(listProfiles));
    } else {
      emit(ListProfilesError());
    }
  }

  _getLoginProfile(GetLoginProfile event, Emitter<ProfileState> emit) async {
    final sessionProfile = await _sessionRepository.getSession();

    if (sessionProfile == null) {
      emit(LoginProfileError());
      return;
    } else {
      if (sessionProfile.id != 0 && sessionProfile.profileId != 0) {
        logger.i(
            'Session: id: ${sessionProfile.id}, profile id ${sessionProfile.profileId}');
        final profile =
            await _profilesRepository.getProfile(sessionProfile.profileId);
        logger.i('Profile ${profile.id} ${profile.name} logged in');
        emit(LoginProfileSuccess(profile));
      } else {
        emit(LoginProfileError());
      }
    }
  }

  _createProfile(CreateProfileEvent event, Emitter<ProfileState> emit) {
    if (event.name.isEmpty) {
      emit(const CreateProfileError(ProfileNameMsg.emptyProfileName));
    } else if (event.name.length < ProfileLimits.minNameLimitChar) {
      emit(const CreateProfileError(ProfileNameMsg.shortProfileName));
    } else if (event.name.length > ProfileLimits.maxNameLimitChar) {
      emit(const CreateProfileError(ProfileNameMsg.longProfileName));
    } else {
      try {
        final profile = Profile(name: event.name, currency: event.currency);
        _profilesRepository.insertProfile(profile);
        emit(CreateProfileSuccess());
        logger.i('Profile ${event.name} created');
      } catch (e) {
        logger.e('Error: ${e.toString()}');
        emit(const CreateProfileError(ProfileNameMsg.errorCreateProfile));
      }
    }
  }

  _updateProfilesList(
      UpdateProfilesListEvent event, Emitter<ProfileState> emit) async {
    add(GetListProfiles());
  }

  _deleteProfile(DeleteProfile event, Emitter<ProfileState> emit) async {
    await _profilesRepository.deleteProfile(event.profile);
    add(GetListProfiles());
  }

  void dispose() {}
}
