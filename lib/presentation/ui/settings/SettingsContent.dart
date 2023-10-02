import 'package:fin_control/domain/DarkModeUseCase.dart';
import 'package:fin_control/presentation/bloc/settings_bloc.dart';
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

    return BlocProvider(
        create: (context) => SettingsBloc(darkModeUseCase),
        child:
            BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
          return Container(
            color: Theme.of(context).colorScheme.background,
            child: Column(children: [
              SettingSwitch(
                state: state.isDarkMode,
                title: 'Dark mode',
                description:
                    'какое то большое описание данной настройки на сколько то там символов крч ты понял нет',
                onClick: (newValue) => {
                  BlocProvider.of<SettingsBloc>(context)
                      .add(DarkModeEvent(isDarkMode: !state.isDarkMode)),
                },
              ),
              const Divider(
                height: 5,
                indent: indent,
                endIndent: indent,
              ),
              SettingSwitch(
                state: false,
                title: 'Баланс скрыт',
                description: 'какое то большое описани понял нет',
                onClick: (newValue) => {},
              ),
              const Divider(
                height: 5,
                indent: indent,
                endIndent: indent,
              ),
              SettingSwitch(
                state: false,
                title: 'Настройка 3',
                description: 'какое то большое описани понял нет',
                onClick: (newValue) => {},
              ),
              const Divider(
                height: 5,
                indent: indent,
                endIndent: indent,
              ),
              SettingSwitch(
                state: false,
                title: 'Настройка 4',
                description: 'какое то большое описани понял нет',
                onClick: (newValue) => {},
              )
            ]),
          );
        }));
  }
}
