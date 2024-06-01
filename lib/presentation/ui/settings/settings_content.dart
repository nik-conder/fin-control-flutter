import 'package:fin_control/data/models/profile.dart';
import 'package:fin_control/data/repository/settings_repository.dart';
import 'package:fin_control/domain/bloc/debug/debug_bloc.dart';
import 'package:fin_control/domain/bloc/profile/profile_bloc.dart';
import 'package:fin_control/domain/bloc/settings/settings_bloc.dart';
import 'package:fin_control/domain/bloc/theme/theme_bloc.dart';
import 'package:fin_control/domain/bloc/theme/theme_event.dart';
import 'package:fin_control/domain/bloc/theme/theme_state.dart';
import 'package:fin_control/presentation/ui/components/box_page_component.dart';
import 'package:fin_control/presentation/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:fin_control/presentation/ui/settings/setting_switch.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../domain/bloc/debug/debug_event.dart';
import '../../../domain/bloc/debug/debug_state.dart';

class SettingsContent extends StatelessWidget {
  final Profile profile;

  const SettingsContent({super.key, required this.profile});

  static const double indent = 8;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    final settingsRepository = GetIt.instance<SettingsRepository>();
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => SettingsBloc(settingsRepository)),
          BlocProvider(create: (context) => DebugBloc()),
        ],
        child: Center(
          child: Column(children: [
            BoxContentComponent(
              paddingContent: const EdgeInsets.all(4),
              header: localization.profile,
              content: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(12),
                            child: Text(
                              "\uD83D\uDC64",
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                          Text(profile.name,
                              style: Theme.of(context).textTheme.titleMedium),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, top: 4, right: 8, bottom: 4),
                                    child: Text(
                                        Utils.getFormattedCurrency(
                                            profile.currency),
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold)),
                                  )),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 12, bottom: 12, right: 12),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, '/login');
                                  },
                                  child: Text(localization.logout)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: TextButton(
                                  onPressed: null,
                                  child: Text(localization.delete)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            BoxContentComponent(
                paddingContent: const EdgeInsets.all(4),
                header: localization.settings,
                content: Column(
                  children: [
                    BlocBuilder<SettingsBloc, SettingsState>(
                        builder: (context, state) {
                      return Column(
                        children: [
                          BlocBuilder<ThemeBloc, ThemeState>(
                              // TODO join bloc to SettingsBloc
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
                          SettingSwitch(
                            state: false,
                            title: localization.block_useful_tips_setting,
                            description: localization
                                .block_useful_tips_setting_description,
                            onClick: (newValue) => {},
                          ),
                          SettingSwitch(
                            state: false,
                            title: localization.hidden_balance,
                            description: localization.hide_balance_description,
                            onClick: (newValue) => {},
                          ),
                          SettingSwitch(
                            state: false, // TODO: default value is true
                            title: localization.transaction_grid,
                            description:
                                localization.transaction_grid_description,
                            onClick: (newValue) => {},
                          ),
                          BlocBuilder<DebugBloc, DebugState>(
                              builder: (context, state) {
                            return SettingSwitch(
                              state: state.debugOn,
                              title: 'Debug mode',
                              description: 'Option for development',
                              onClick: (newValue) => {
                                BlocProvider.of<DebugBloc>(context)
                                    .add(DebugOnEvent()),
                              },
                            );
                          })
                        ],
                      );
                    }),
                  ],
                ))
          ]),
        ));
  }
}
