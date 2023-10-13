import 'package:fin_control/data/repository/settings_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:developer' as developer;

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository _settingsRepository;

  SettingsBloc(this._settingsRepository) : super(const SettingsState()) {
    on<GetDarkModeEvent>(_getDarkMode);
  }

  _getDarkMode(GetDarkModeEvent event, Emitter<SettingsState> emit) async {
    try {
      //bool isDarkMode = await _settingsRepository.getDarkModeSetting();
      bool isDarkMode = false;

      emit(state.copyWith(isDarkMode: (isDarkMode == 1) ? true : false));
      developer.log('dark mode: $isDarkMode', time: DateTime.now());
    } catch (e) {
      developer.log('', time: DateTime.now(), error: 'Error getting dark mode');
    }
  }
}
