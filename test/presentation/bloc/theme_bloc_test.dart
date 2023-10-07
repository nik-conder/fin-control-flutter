import 'package:fin_control/domain/bloc/theme/theme_bloc.dart';
import 'package:fin_control/domain/bloc/theme/theme_event.dart';
import 'package:fin_control/domain/bloc/theme/theme_state.dart';
import 'package:bloc_test/bloc_test.dart';

class MockThemeBloc extends MockBloc<ThemeEvent, ThemeState>
    implements ThemeBloc {}

void main() {
  mainBloc();
}

void mainBloc() {
  // group('whenListen', () {
  //   late MockThemeBloc bloc;

  //   setUp(() {
  //     bloc = MockThemeBloc();
  //   });
  //   blocTest<ThemeBloc, ThemeState>(
  //     'emits [ThemeState(isDarkMode: true)] when UpdateThemeEvent is added',
  //     build: () => MockThemeBloc(),
  //     act: (bloc) {
  //       bloc.add(UpdateThemeEvent());
  //     },
  //     expect: () => const <ThemeState>[
  //       ThemeState(isDarkMode: true),
  //     ],
  //   );

  //   blocTest<ThemeBloc, ThemeState>(
  //     'emits [ThemeState(isDarkMode: false)] when UpdateThemeEvent is added twice',
  //     build: () => bloc,
  //     act: (bloc) {
  //       bloc.add(UpdateThemeEvent());
  //       bloc.add(UpdateThemeEvent());
  //     },
  //     verify: (bloc) {
  //       verify(bloc.add(UpdateThemeEvent()));
  //     },
  //     expect: () => const <ThemeState>[
  //       ThemeState(isDarkMode: true),
  //       ThemeState(isDarkMode: false),
  //     ],
  //   );

  //   tearDown(() {
  //     bloc.close();
  //   });
  // });
}
