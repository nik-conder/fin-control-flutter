import 'package:fin_control/domain/bloc/profile/profile_bloc.dart';
import 'package:fin_control/domain/bloc/settings/settings_bloc.dart';
import 'package:fin_control/domain/bloc/theme/theme_bloc.dart';
import 'package:fin_control/domain/bloc/theme/theme_event.dart';
import 'package:fin_control/domain/bloc/theme/theme_state.dart';
import 'package:fin_control/main.dart';
import 'package:fin_control/presentation/ui/components/box_page_component.dart';
import 'package:fin_control/presentation/ui/components/setting_token_component.dart';
import 'package:fin_control/presentation/ui/info_content.dart';
import 'package:flutter/material.dart';
import 'package:fin_control/presentation/ui/settings/setting_switch.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';

import '../../utils/utils.dart';
import '../components/accounts_list_component.dart';

class SettingsContent extends StatefulWidget {
  const SettingsContent({super.key});

  @override
  State<SettingsContent> createState() => _SettingsContentState();
}

class _SettingsContentState extends State<SettingsContent> {
  @override
  void initState() {
    super.initState();

    //context.read<AccountBloc>().add(FetchAccounts());
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => GetIt.I<SettingsBloc>()),
        ],
        child: Center(
          child: Column(children: [
            BoxContentComponent(
              paddingContent: const EdgeInsets.all(4),
              header: localization.profile,
              content: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is LoginProfileSuccess) {
                    final profile = state.profile;
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
                                      Navigator.pushNamedAndRemoveUntil(
                                          context, '/login', (route) => false);
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
                  } else {
                    return InfoContent(InfoPageType.noData);
                  }
                },
              ),
            ),
            BoxContentComponent(
                paddingContent: const EdgeInsets.all(4),
                header: 'Аккаунты',
                content: AccountsListComponent()),
            const BoxContentComponent(
              paddingContent: EdgeInsets.all(4),
              header: 'Токен',
              content: Column(
                children: [
                  SettingTokenComponent(),
                ],
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
                        ],
                      );
                    }),
                  ],
                ))
          ]),
        ));
  }
}
