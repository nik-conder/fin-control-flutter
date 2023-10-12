import 'dart:async';
import 'dart:developer' as developer;
import 'dart:math';
import 'package:fin_control/data/models/profile.dart';
import 'package:fin_control/data/repository/profiles_repository.dart';
import 'package:fin_control/domain/bloc/profile/profile_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  late Timer timer;

  final ProfilesRepository _profilesRepository =
      GetIt.instance<ProfilesRepository>();

  Stream<double> get getBalanceStream async* {
    yield* _profilesRepository.getBalance(1); // todo
  }

  final StreamController<double> _controller = StreamController<double>();

  Stream<double> get balanceStream => _controller.stream;

  ProfileBloc() : super(ProfileInitial()) {
    on<CreateProfileEvent>(_createProfile);
    on<GetBalanceEvent>((event, emit) async {});
    on<UpdateBalance>(
      (event, emit) async {
        try {
          await _profilesRepository.updateBalance(event.id, event.balance);
          final getBalance = await _profilesRepository.getBalance(1);
          getBalance.listen((event) {
            _controller.add(event);
          });
        } catch (e) {
          developer.log('', time: DateTime.now(), error: e.toString());
        }
      },
    );
    getBalanceStream.listen((event) async {
      await Future<void>.delayed(const Duration(seconds: 2));
      _controller.add(event);
    });

    timer = Timer.periodic(const Duration(seconds: 2), (Timer t) async {
      final profiles = _profilesRepository.getBalance(1);
      profiles.listen((list) {
        _controller.add(list);
      });
    });
  }

  _getProfile() async {
    try {
      final profile = await _profilesRepository.getProfile(1);
      emit(ProfileLoadSuccess(profile));
    } catch (e) {
      emit(ProfileError('Error'));
    }
  }

  _createProfile(CreateProfileEvent event, Emitter<ProfileState> emit) {
    try {
      final profile = Profile(name: event.name);

      final result = _profilesRepository.insertProfile(profile);

      developer.log('всё ок', time: DateTime.now());
      developer.log('Inserted Rows: $result', time: DateTime.now());
      emit(CreateProfileSuccess());
    } catch (e) {
      developer.log('',
          time: DateTime.now(), error: 'Ошибка при создании профиля');
      emit(CreateProfileError('Error'));
    }
  }

  @override
  Future<void> close() {
    timer.cancel();
    return super.close();
  }
}
