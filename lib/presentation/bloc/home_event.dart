part of 'home_bloc.dart';

abstract class HomeEvent {}

class OpacitySetEvent extends HomeEvent {
  final double toolBarOpacity;
  OpacitySetEvent(this.toolBarOpacity);
}

class UpdateBalance extends HomeEvent {
  final double balance;
  UpdateBalance(this.balance);
}

class BalanceVisible extends HomeEvent {
  final bool balanceIsVisibile;
  BalanceVisible(this.balanceIsVisibile);
}
