import 'package:fin_control/domain/DarkModeUseCase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final DarkModeUseCase _darkModeUseCase;

  SettingsBloc(this._darkModeUseCase) : super(const SettingsState()) {
    on<SetDarkModeEvent>(_setDarkMode);
    on<GetDarkModeEvent>(_getDarkMode);
  }

  _setDarkMode(SetDarkModeEvent event, Emitter<SettingsState> emit) {
    emit(state.copyWith(isDarkMode: (event.isDarkMode ? true : false)));
  }

  _getDarkMode(GetDarkModeEvent event, Emitter<SettingsState> emit) async {
    try {
      int isDarkMode = await _darkModeUseCase.getDarkMode();
      emit(state.copyWith(isDarkMode: (isDarkMode == 1) ? true : false));
      print("dark mode: $isDarkMode");
    } catch (e) {
      print("Error: $e");
    }
  }
}
