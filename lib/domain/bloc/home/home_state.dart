part of 'home_bloc.dart';

final class HomeState extends Equatable {
  const HomeState({
    this.toolBarOpacity = 1.0,
    this.isValid = false,
    this.balance = 0.0,
    this.balanceIsVisibile = true,
  });

  final double toolBarOpacity;
  final bool isValid;
  final double balance;
  final bool balanceIsVisibile;

  HomeState copyWith({
    double? toolBarOpacity,
    bool? isValid,
    double? balance,
    bool? balanceIsVisibile,
  }) {
    return HomeState(
      toolBarOpacity: toolBarOpacity ?? this.toolBarOpacity,
      isValid: isValid ?? this.isValid,
      balance: balance ?? this.balance,
      balanceIsVisibile: balanceIsVisibile ?? this.balanceIsVisibile,
    );
  }

  @override
  List<Object> get props =>
      [toolBarOpacity, isValid, balance, balanceIsVisibile];
}
