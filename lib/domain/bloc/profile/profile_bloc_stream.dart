import 'package:fin_control/domain/bloc/profile/profile_bloc.dart';
import 'package:stream_bloc/stream_bloc.dart';

class ProfileBlocStream extends StreamBloc<ProfileEvent, ProfileState> {
  ProfileBlocStream() : super(const ProfileState(id: 0, name: ''));

  @override
  @override
  Stream<ProfileState> mapEventToStates(ProfileEvent event) async* {
    // TODO: implement mapEventToStates
  }
}
