import 'package:equatable/equatable.dart';
import 'package:fin_control/core/logger.dart';
import 'package:fin_control/domain/useCases/auth_use_case.dart';
import 'package:fin_control/domain/useCases/settings_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'token_event.dart';
part 'token_state.dart';

class TokenBloc extends Bloc<TokenEvent, TokenState> {
  final SettingsUseCase _settingsUseCase;
  final AuthUseCase _authUseCase;
  TokenBloc(this._settingsUseCase, this._authUseCase)
      : super(GetTokenInitial()) {
    on<GetToken>(_getToken);
    on<SetToken>(_setToken);
    on<DeleteToken>(_deleteToken);
  }

  _getToken(GetToken event, Emitter<TokenState> emit) async {
    try {
      // String? token = await _settingsUseCase.getToken();
      // emit(state.copyWith(token: token));
      // developer.log('token: $token', time: DateTime.now());
      emit(GetTokenLoading());

      await Future.delayed(Duration(seconds: 3));

      final result = await _authUseCase.getToken('token');
      logger.e(result);

      if (result != null) {
        emit(GetTokenSuccess(result));
      } else {
        emit(GetTokenError("Error getting token"));
      }

      //emit(GetTokenSuccess('key32testtokenpizdadickpussy1234'));
    } catch (e) {
      // emit(state.copyWith(token: null));
      // developer.log('', time: DateTime.now(), error: 'Error getting token');
    }
  }

  _setToken(SetToken event, Emitter<TokenState> emit) async {
    try {
      await _authUseCase.saveToken(event.value);

      final test = await _authUseCase.getToken('token');

      if (test != null) {
        emit(GetTokenSuccess(test));
        emit(SetTokenSuccess());
        add(GetToken());
      } else {
        emit(SetTokenError("Error saving token"));
      }
    } catch (e) {
      logger.e('Error saving token "${event.value}", $e');
    }
  }

  _deleteToken(DeleteToken event, Emitter<TokenState> emit) async {
    try {
      await _authUseCase.deleteToken();
      //emit(DeleteTokenSuccess());
      add(GetToken());
    } catch (e) {
      logger.e('Error deleting token, $e');
    }
  }
}
