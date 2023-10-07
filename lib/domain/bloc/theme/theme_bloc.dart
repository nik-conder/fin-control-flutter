import 'package:fin_control/data/repository/settings_repository.dart';
import 'package:fin_control/domain/bloc/theme/theme_event.dart';
import 'package:fin_control/domain/bloc/theme/theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final SettingsRepository _settingsRepository;

  ThemeBloc(this._settingsRepository) : super(const ThemeState()) {
    on<UpdateThemeEvent>(_updateTheme);
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
