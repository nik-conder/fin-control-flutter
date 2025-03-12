part of 'token_bloc.dart';

sealed class TokenEvent extends Equatable {
  const TokenEvent();

  @override
  List<Object> get props => [];
}

class GetToken extends TokenEvent {}

class SetToken extends TokenEvent {
  String value;

  SetToken(this.value);
}

class DeleteToken extends TokenEvent {}
