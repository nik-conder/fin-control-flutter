import 'package:fin_control/domain/DarkModeUseCase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final DarkModeUseCase _darkModeUseCase;

  SettingsBloc(this._darkModeUseCase) : super(const SettingsState()) {
    on<DarkModeEvent>(_setDarkMode);
  }

  _setDarkMode(DarkModeEvent event, Emitter<SettingsState> emit) {
    final void result = _darkModeUseCase.isDarkMode(event.isDarkMode);
    emit(state.copyWith(isDarkMode: (event.isDarkMode ? true : false)));
  }
}
