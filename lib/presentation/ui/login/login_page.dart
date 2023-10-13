import 'package:fin_control/domain/bloc/profile/list/profile_list_bloc.dart';
import 'package:fin_control/domain/bloc/profile/profile_bloc.dart';
import 'package:fin_control/domain/bloc/theme/theme_bloc.dart';
import 'package:fin_control/domain/bloc/theme/theme_event.dart';
import 'package:fin_control/domain/bloc/theme/theme_state.dart';
import 'package:fin_control/presentation/ui/login/login_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final profileBloc = GetIt.instance<ProfileBloc>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Login'), actions: [
          BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
            return Tooltip(
                message: (state.isDarkMode) ? 'Light mode' : 'Dark mode',
                child: IconButton(
                  onPressed: () {
                    BlocProvider.of<ThemeBloc>(context).add(UpdateThemeEvent());
                  },
                  icon: (state.isDarkMode)
                      ? const Icon(Icons.light_mode_outlined)
                      : const Icon(Icons.dark_mode_outlined),
                ));
          })
        ]),
        body: BlocProvider(
          create: (context) => profileBloc,
          child: MultiBlocProvider(providers: [
            BlocProvider<ProfileListBloc>(
                create: (context) => ProfileListBloc()),
          ], child: LoginContent()),
        ),
      ),
    );
  }
}
