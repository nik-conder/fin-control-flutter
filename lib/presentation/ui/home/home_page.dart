import 'package:fin_control/config.dart';
import 'package:fin_control/domain/bloc/home/home_bloc.dart';
import 'package:fin_control/domain/bloc/theme/theme_bloc.dart';
import 'package:fin_control/domain/bloc/theme/theme_event.dart';
import 'package:fin_control/domain/bloc/theme/theme_state.dart';
import 'package:fin_control/presentation/ui/home/foot_home_component.dart';
import 'package:fin_control/presentation/ui/home/head_home_component.dart';
import 'package:fin_control/presentation/ui/profile/profile_info_block.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return AppBar(
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
            );
          },
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 8,
                ),
                child: HeadHomeComponent(
                  balance: state.balance,
                  balanceIsVisibile: state.balanceIsVisibile,
                  onPressed: () => BlocProvider.of<HomeBloc>(context)
                      .add(UpdateBalance(state.balance + 100)),
                  onBalanceIsVisibile: () => BlocProvider.of<HomeBloc>(context)
                      .add(BalanceVisible(!state.balanceIsVisibile)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  color: Colors.red,
                  child: const Row(
                    children: [
                      Column(
                        children: [Text("1 колонка")],
                      ),
                      Column(
                        children: [Text("2 колонка")],
                      ),
                      Column(children: [Text("3 колонка")])
                    ],
                  ),
                ),
              ),
              const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: ProfileInfoBloc()),
              Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    color: Colors.cyan,
                    child: Row(
                      children: [
                        Slider(
                          label: state.toolBarOpacity.toString(),
                          max: 1.0,
                          min: 0.0,
                          divisions: 5,
                          value: state.toolBarOpacity,
                          onChanged: (newValue) {
                            BlocProvider.of<HomeBloc>(context)
                                .add(OpacitySetEvent(newValue));
                          },
                        )
                      ],
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: const FootHomeComponent(),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
