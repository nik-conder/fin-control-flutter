import 'package:fin_control/config.dart';
import 'package:fin_control/data/models/profile.dart';
import 'package:fin_control/domain/bloc/session/session_bloc.dart';
import 'package:fin_control/domain/bloc/session/session_event.dart';
import 'package:fin_control/domain/bloc/theme/theme_bloc.dart';
import 'package:fin_control/domain/bloc/theme/theme_event.dart';
import 'package:fin_control/domain/bloc/theme/theme_state.dart';
import 'package:fin_control/presentation/ui/home/foot_component.dart';
import 'package:fin_control/presentation/ui/home/home_content.dart';
import 'package:fin_control/presentation/ui/home/home_head.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final sessionBloc = BlocProvider.of<SessionBloc>(context);

    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final Profile profile = args['profile'];

    final localization = AppLocalizations.of(context)!;

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(GeneralConfig.appName),
            actions: [
              Tooltip(
                  message: (state.isDarkMode)
                      ? localization.light_mode
                      : localization.dark_mode,
                  child: IconButton(
                    onPressed: () {
                      BlocProvider.of<ThemeBloc>(context)
                          .add(UpdateThemeEvent());
                    },
                    icon: (state.isDarkMode)
                        ? const Icon(Icons.light_mode_outlined)
                        : const Icon(Icons.dark_mode_outlined),
                  )),
              Tooltip(
                message: localization.title_settings,
                child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                  icon: const Icon(Icons.settings_outlined),
                ),
              ),
              Tooltip(
                  message: localization.title_logout,
                  child: IconButton(
                    onPressed: () {
                      //Navigator.pushReplacementNamed(context, '/login');
                      BlocProvider.of<SessionBloc>(context)
                          .add(SessionDeleteEvent());
                      Navigator.popAndPushNamed(context, '/login');
                    },
                    icon: const Icon(Icons.logout_outlined),
                  )),
            ],
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                HomeHead(profile: profile),
                const HomeContent(),
                const FootComponent()
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
