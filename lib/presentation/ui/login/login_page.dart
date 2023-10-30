import 'package:fin_control/domain/bloc/theme/theme_bloc.dart';
import 'package:fin_control/domain/bloc/theme/theme_event.dart';
import 'package:fin_control/domain/bloc/theme/theme_state.dart';
import 'package:fin_control/presentation/ui/login/login_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(actions: [
        BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
          return Tooltip(
              message: (state.isDarkMode)
                  ? localization.light_mode
                  : localization.dark_mode,
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
      body: LoginContent(),
    );
  }
}
