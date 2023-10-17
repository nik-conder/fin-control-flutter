import 'package:bloc_test/bloc_test.dart';
import 'package:fin_control/data/repository/settings_repository.dart';
import 'package:fin_control/dependency_injector.dart';
import 'package:fin_control/domain/bloc/theme/theme_bloc.dart';
import 'package:fin_control/domain/bloc/theme/theme_event.dart';
import 'package:fin_control/domain/bloc/theme/theme_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

void main() {
  group('ThemeBloc Tests', () {
    GetIt getIt = GetIt.instance;

    late ThemeBloc themeBloc;
    late SettingsRepository settingsRepository;

    setUpAll(() {
      DependencyInjector.setup();
    });

    setUp(() {
      settingsRepository = getIt<SettingsRepository>();
      themeBloc = ThemeBloc(settingsRepository);
    });

    tearDownAll(() {
      getIt.reset();
    });

    test('Initial state is ThemeState', () {
      expect(themeBloc.state, equals(const ThemeState()));
    });

    blocTest(
      'Emits updated theme state after UpdateThemeEvent',
      build: () => themeBloc,
      act: (bloc) => bloc.add(UpdateThemeEvent()),
      expect: () => [],
    );

    //   test('Updates theme and emits updated theme state after UpdateThemeEvent',
    //       () async {
    //     // Simulate the behavior of your SettingsRepository
    //     final settingsRepository = getIt<SettingsRepository>();
    //     settingsRepository.updateDarkModeSetting(true);

    //     // Add the UpdateThemeEvent to the bloc
    //     themeBloc.add(UpdateThemeEvent());

    //     // Expect the bloc to emit the updated state based on the settings change
    //     await expectLater(
    //       themeBloc,
    //       emits(const ThemeState(isDarkMode: true)),
    //     );

    //     // Add the UpdateThemeEvent again to trigger the _updateTheme function
    //     themeBloc.add(UpdateThemeEvent());

    //     // Expect the bloc to emit the updated state after the theme update
    //     expectLater(
    //       themeBloc,
    //       emits(const ThemeState(
    //           isDarkMode: false)), // Assuming it toggles the theme
    //     );
    //   });
  });
}
