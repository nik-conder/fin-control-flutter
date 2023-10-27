import 'dart:async';
import 'dart:developer' as developer;
import 'dart:math';
import 'package:decimal/decimal.dart';
import 'package:fin_control/config.dart';
import 'package:fin_control/data/models/currency.dart';
import 'package:fin_control/data/models/profile.dart';
import 'package:fin_control/data/models/transaction.dart';
import 'package:fin_control/data/repository/profiles_repository.dart';
import 'package:fin_control/data/repository/transactions_repository.dart';
import 'package:fin_control/presentation/utils/sysmsg.dart';
import 'package:fin_control/domain/bloc/profile/profile_event.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final _profilesRepository = GetIt.instance<ProfilesRepository>();
  final _transactionsRepository = GetIt.instance<TransactionsRepository>();

  final BehaviorSubject<double> _balanceSubject = BehaviorSubject<double>();

  Stream<double> get balanceStream => _balanceSubject.stream;

  final BehaviorSubject<List<Profile>> _profilesSubject =
      BehaviorSubject<List<Profile>>();

  Stream<List<Profile>> get profilesStream => _profilesSubject.stream;

  ProfileBloc() : super(ProfileInitial()) {
    on<CreateProfileEvent>(_createProfile);
    on<CreateDemoProfileEvent>(_createDemoProfile);
    on<UpdateProfilesListEvent>(_updateProfilesList);
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

  _updateProfilesList(
      UpdateProfilesListEvent event, Emitter<ProfileState> emit) async {
    final result = _profilesRepository.getAllProfiles();

    result.listen((event) {
      if (event.isNotEmpty) _profilesSubject.sink.add(event);
      print(profilesStream.length);
    }, onError: (error) {
      _profilesSubject.addError(error);
    });
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
    emit(ProfileInitial()); // TODO костыль

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
      } catch (e) {
        developer.log('',
            time: DateTime.now(), error: 'Error: ${e.toString()}');
        emit(const CreateProfileError(ProfileNameMsg.errorCreateProfile));
      }
    }
  }

  _createDemoProfile(
      CreateDemoProfileEvent event, Emitter<ProfileState> emit) async {
    try {
      final profile =
          Profile(name: 'Demo', currency: Currency.eur, balance: 12345);
      _profilesRepository.insertProfile(profile);

      final random = Random();

      for (int i = 0; i < 10; i++) {
        double randomDouble = 100 + random.nextDouble() * (10000 - 100);
        final transaction = FinTransaction(
            profileId: 1,
            type: random.nextBool()
                ? TransactionType.income
                : TransactionType.expense,
            amount: Decimal.parse(randomDouble.toString()),
            datetime: DateTime.now(),
            category: 'test',
            note: 'Note $i');
        await _transactionsRepository.insertTransaction(transaction);
      }

      add(UpdateProfilesListEvent());

      emit(CreateProfileSuccess());
    } catch (e) {
      developer.log('', time: DateTime.now(), error: 'Error: ${e.toString()}');
      emit(const CreateProfileError(ProfileNameMsg.errorCreateProfile));
    }
  }

  void dispose() {
    _profilesSubject.close();
    _balanceSubject.close();
  }
}
