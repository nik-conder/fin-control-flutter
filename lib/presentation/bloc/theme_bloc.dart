import 'package:fin_control/domain/DarkModeUseCase.dart';
import 'package:fin_control/presentation/bloc/theme_event.dart';
import 'package:fin_control/presentation/bloc/theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final DarkModeUseCase _darkModeUseCase;

  ThemeBloc(this._darkModeUseCase) : super(const ThemeState()) {
    on<UpdateThemeEvent>(_updateTheme);
  }

  _updateTheme(UpdateThemeEvent event, Emitter<ThemeState> emit) async {
    await _darkModeUseCase.isDarkMode(!state.isDarkMode);

    emit(state.copyWith(isDarkMode: !state.isDarkMode));
  }
}
