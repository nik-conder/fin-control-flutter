import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:developer' as developer;

import '../../useCases/settings_use_case.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsUseCase _settingsUseCase;

  SettingsBloc(this._settingsUseCase) : super(SettingsState()) {}

  _getDarkMode(GetDarkModeEvent event, Emitter<SettingsState> emit) async {
    try {
      bool isDarkMode = await _settingsUseCase.getDarkModeSetting();

      emit(state.copyWith(isDarkMode: (isDarkMode == true) ? true : false));
      developer.log('dark mode: $isDarkMode', time: DateTime.now());
    } catch (e) {
      developer.log('', time: DateTime.now(), error: 'Error getting dark mode');
    }
  }
}
