import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<OpacitySetEvent>(_setOpacity);
    on<UpdateBalance>(_setBalance);
    on<BalanceVisible>(_setBalanceVisible);
  }

  _setOpacity(OpacitySetEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(
      toolBarOpacity: event.toolBarOpacity,
    ));
  }

  _setBalance(UpdateBalance event, Emitter<HomeState> emit) {
    final random = Random();
    double balance = event.balance + 100 + random.nextDouble() * (1000 - 100);
    emit(state.copyWith(
      balance: balance,
    ));
  }

  _setBalanceVisible(BalanceVisible event, Emitter<HomeState> emit) {
    emit(state.copyWith(
      balanceIsVisibile: event.balanceIsVisibile,
    ));
  }
}
