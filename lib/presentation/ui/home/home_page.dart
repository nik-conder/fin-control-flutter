import 'package:fin_control/config.dart';
import 'package:fin_control/domain/bloc/home/home_bloc.dart';
import 'package:fin_control/domain/bloc/profile/profile_bloc.dart';
import 'package:fin_control/domain/bloc/theme/theme_bloc.dart';
import 'package:fin_control/domain/bloc/theme/theme_event.dart';
import 'package:fin_control/domain/bloc/theme/theme_state.dart';
import 'package:fin_control/presentation/ui/home/foot_component.dart';
import 'package:fin_control/presentation/ui/home/home_content.dart';
import 'package:fin_control/presentation/ui/home/home_head.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(GeneralConfig.appName),
            actions: [
              Tooltip(
                  message: (state.isDarkMode) ? 'Light mode' : 'Dark mode',
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
                message: 'Settings',
                child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                  icon: const Icon(Icons.settings_outlined),
                ),
              ),
              Tooltip(
                  message: 'Log out',
                  child: IconButton(
                    onPressed: () {
                      //Navigator.pushReplacementNamed(context, '/login');
                      Navigator.popAndPushNamed(context, '/login');
                    },
                    icon: const Icon(Icons.logout_outlined),
                  )),
            ],
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          body: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => HomeBloc(),
              ),
              BlocProvider(
                create: (context) => ProfileBloc(),
              )
            ],
            child: Column(
              children: [
                HomeHead(),
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
