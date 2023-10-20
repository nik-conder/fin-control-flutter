import 'package:fin_control/data/repository/settings_repository.dart';
import 'package:fin_control/domain/bloc/settings/settings_bloc.dart';
import 'package:fin_control/domain/bloc/theme/theme_bloc.dart';
import 'package:fin_control/domain/bloc/theme/theme_event.dart';
import 'package:fin_control/domain/bloc/theme/theme_state.dart';
import 'package:fin_control/presentation/ui/components/box_page_component.dart';
import 'package:flutter/material.dart';
import 'package:fin_control/presentation/ui/settings/setting_switch.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsContent extends StatelessWidget {
  const SettingsContent({super.key});

  static const double indent = 8;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    final settingsRepository = GetIt.instance<SettingsRepository>();
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => SettingsBloc(settingsRepository)),
        ],
        child: BoxContentComponent(
            paddingContent: const EdgeInsets.all(4),
            header: localization.title_settings,
            content: Column(
              children: [
                Row(
                  children: [
                    BlocBuilder<ThemeBloc, ThemeState>(
                        builder: (context, state) {
                      return SettingSwitch(
                        state: state.isDarkMode,
                        title: localization.dark_mode,
                        onClick: (newValue) => {
                          BlocProvider.of<ThemeBloc>(context)
                              .add(UpdateThemeEvent()),
                        },
                      );
                    }),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SettingSwitch(
                      state: false,
                      title: 'Test title option',
                      description: 'test description option',
                      onClick: (newValue) => {},
                    )
                  ],
                )
              ],
            )));
  }
}
