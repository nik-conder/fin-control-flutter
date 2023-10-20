import 'package:fin_control/data/repository/settings_repository.dart';
import 'package:fin_control/domain/bloc/theme/theme_event.dart';
import 'package:fin_control/domain/bloc/theme/theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as developer;

import 'package:rxdart/rxdart.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final SettingsRepository _settingsRepository;

  ThemeBloc(this._settingsRepository) : super(const ThemeState()) {
    on<UpdateThemeEvent>(_updateTheme);
    on<ThemeInitial>(_getTheme);
  }

  _getTheme(ThemeInitial event, Emitter<ThemeState> emit) async {
    final result = await _settingsRepository.getDarkModeSetting();

    emit(ThemeState(isDarkMode: result));
    developer.log('Theme initial: $result', time: DateTime.now());
  }

  _updateTheme(UpdateThemeEvent event, Emitter<ThemeState> emit) async {
    final result =
        await _settingsRepository.updateDarkModeSetting(!state.isDarkMode);

    if (result == 1) {
      emit(ThemeState(isDarkMode: !state.isDarkMode));
      developer.log('Theme update: $result', time: DateTime.now());
    }
  }
}
