import 'package:bloc_test/bloc_test.dart';
import 'package:fin_control/data/repository/settings_repository.dart';
import 'package:fin_control/dependency_injector.dart';
import 'package:fin_control/domain/bloc/theme/theme_bloc.dart';
import 'package:fin_control/domain/bloc/theme/theme_event.dart';
import 'package:fin_control/domain/bloc/theme/theme_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

void main() {
  GetIt getIt = GetIt.instance;

  late ThemeBloc themeBloc;

  setUp(() {
    DependencyInjector.setup();
    themeBloc = getIt<ThemeBloc>();
  });

  group('ThemeBloc Tests', () {
    test('initial state is 0', () {
      expect(themeBloc.state.isDarkMode, false);
    });

    //   blocTest(
    //     'emit isDarkMode = true when toggleDarkMode is called',
    //     build: () => themeBloc,
    //     act: (bloc) => bloc.add(UpdateThemeEvent()),
    //     expect: () => true,
    //   );
  });

  tearDown(() {
    getIt.reset();
  });
}
