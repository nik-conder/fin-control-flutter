import 'dart:async';

import 'package:fin_control/data/repository/settings_repository.dart';
import 'package:fin_control/domain/bloc/theme/theme_event.dart';
import 'package:fin_control/domain/bloc/theme/theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final SettingsRepository _settingsRepository;

  final BehaviorSubject<bool> _profileListSubject = BehaviorSubject<bool>();

  Stream<bool> get isDarkModeStream => _profileListSubject.stream;

  // Stream<bool> get _isDarkModeStream =>
  //     _settingsRepository.getDarkModeSetting();

  ThemeBloc(this._settingsRepository) : super(const ThemeState()) {
    on<UpdateThemeEvent>(_updateTheme);
    _settingsRepository.getDarkModeSetting().listen((event) {
      emit(state.copyWith(isDarkMode: event));
    });
  }

  _updateTheme(UpdateThemeEvent event, Emitter<ThemeState> emit) async {
    await _settingsRepository.updateDarkModeSetting(!state.isDarkMode);

    emit(state.copyWith(isDarkMode: !state.isDarkMode));
  }

  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is UpdateThemeEvent) {
      yield const ThemeState(isDarkMode: true);
    }
  }
}
