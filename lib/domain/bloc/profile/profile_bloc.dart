import 'dart:async';
import 'dart:developer' as developer;
import 'dart:math';
import 'package:fin_control/data/models/profile.dart';
import 'package:fin_control/data/repository/profiles_repository.dart';
import 'package:fin_control/domain/bloc/profile/profile_event.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final _profilesRepository = GetIt.instance<ProfilesRepository>();

  final BehaviorSubject<double> _balanceSubject = BehaviorSubject<double>();

  Stream<double> get balanceStream => _balanceSubject.stream;

  ProfileBloc() : super(ProfileInitial()) {
    on<CreateProfileEvent>(_createProfile);
    on<ChangeBalance>(
      (event, emit) async {
        await _changeBalance(event, emit);
      },
    );
    on<UpdateBalance>(
      (event, emit) async {
        await _updateBalance(event, emit);
      },
    );
  }

  _updateBalance(UpdateBalance event, Emitter<ProfileState> emit) async {
    final result = await _profilesRepository.getBalance(event.id);
    _balanceSubject.add(result);
  }

  _changeBalance(ChangeBalance event, Emitter<ProfileState> emit) async {
    final random = Random();
    double randomDouble = 100 + random.nextDouble() * (10000 - 100);
    try {
      final result =
          await _profilesRepository.updateBalance(event.id, randomDouble);

      if (result == 1) add(UpdateBalance(event.id));
    } catch (e) {
      developer.log('', time: DateTime.now(), error: e.toString());
    }
  }

  _createProfile(CreateProfileEvent event, Emitter<ProfileState> emit) {
    try {
      final profile = Profile(name: event.name, currency: event.currency);

      final result = _profilesRepository.insertProfile(profile);

      developer.log('всё ок', time: DateTime.now());
      developer.log('Inserted Rows: $result', time: DateTime.now());
      emit(CreateProfileSuccess());
    } catch (e) {
      developer.log('',
          time: DateTime.now(), error: 'Ошибка при создании профиля');
      emit(const CreateProfileError('Error'));
    }
  }
}
