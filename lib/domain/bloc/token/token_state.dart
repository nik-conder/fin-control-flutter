part of 'token_bloc.dart';

sealed class TokenState {}

class GetTokenInitial extends TokenState {}

class GetTokenLoading extends TokenState {}

class GetTokenSuccess extends TokenState {
  final String token;
  GetTokenSuccess(this.token);
}

class GetTokenError extends TokenState {
  final String error;
  GetTokenError(this.error);
}

class SetTokenInitial extends TokenState {}

class SetTokenLoading extends TokenState {}

class SetTokenSuccess extends TokenState {}

class SetTokenError extends TokenState {
  final String error;
  SetTokenError(this.error);
}
