import 'package:fin_control/domain/DarkModeUseCase.dart';
import 'package:fin_control/presentation/bloc/settings_bloc.dart';
import 'package:fin_control/presentation/bloc/theme_bloc.dart';
import 'package:fin_control/presentation/bloc/theme_event.dart';
import 'package:fin_control/presentation/bloc/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:fin_control/presentation/ui/settings/SettingSwitch.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SettingsContent extends StatelessWidget {
  const SettingsContent({super.key});

  static const double indent = 8;

  @override
  Widget build(BuildContext context) {
    final darkModeUseCase = GetIt.instance<DarkModeUseCase>();
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => SettingsBloc(darkModeUseCase)),
        ],
        child: Container(
            color: Theme.of(context).colorScheme.background,
            child: Column(
              children: [
                BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
                  return SettingSwitch(
                    state: state.isDarkMode,
                    title: 'Dark mode',
                    description:
                        'какое то большое описание данной настройки на сколько то там символов крч ты понял нет',
                    onClick: (newValue) => {
                      BlocProvider.of<ThemeBloc>(context)
                          .add(UpdateThemeEvent()),
                    },
                  );
                }),
                const Divider(
                  height: 5,
                  indent: indent,
                  endIndent: indent,
                ),
              ],
            )));
  }
}
