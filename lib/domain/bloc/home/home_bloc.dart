import 'dart:math';
import 'dart:developer' as developer;
import 'package:fin_control/data/repository/profiles_repository.dart';
import 'package:fin_control/domain/bloc/profile/profile_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final _profileRepository = GetIt.instance<ProfilesRepository>();

  HomeBloc() : super(const HomeState()) {
    on<OpacitySetEvent>(_setOpacity);
    on<BalanceVisible>(_setBalanceVisible);
  }

  _setOpacity(OpacitySetEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(
      toolBarOpacity: event.toolBarOpacity,
    ));
  }

  _setBalanceVisible(BalanceVisible event, Emitter<HomeState> emit) {
    emit(state.copyWith(
      balanceIsVisibile: event.balanceIsVisibile,
    ));
  }
}
