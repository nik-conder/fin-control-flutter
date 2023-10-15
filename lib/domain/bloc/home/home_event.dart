part of 'home_bloc.dart';

abstract class HomeEvent {}

class OpacitySetEvent extends HomeEvent {
  final double toolBarOpacity;
  OpacitySetEvent(this.toolBarOpacity);
}

class BalanceVisibleEvent extends HomeEvent {
  final bool balanceIsVisibile;
  BalanceVisibleEvent(this.balanceIsVisibile);
}
