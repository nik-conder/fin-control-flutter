import 'package:fin_control/config.dart';
import 'package:fin_control/dependency_injector.dart';
import 'package:fin_control/domain/bloc/home/home_bloc.dart';
import 'package:fin_control/domain/bloc/theme/theme_bloc.dart';
import 'package:fin_control/domain/bloc/theme/theme_state.dart';
import 'package:fin_control/presentation/ui/home/home_page.dart';
import 'package:fin_control/presentation/ui/login/login_page.dart';
import 'package:fin_control/presentation/ui/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'color_schemes.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  //DBFactory.setup();
  DependencyInjector.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeBloc = GetIt.instance<ThemeBloc>();
    final homeBloc = GetIt.instance<HomeBloc>();

    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => themeBloc),
          BlocProvider(create: (context) => homeBloc),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
          return MaterialApp(
            title: GeneralConfig.appName,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                useMaterial3: true,
                colorScheme:
                    (state.isDarkMode) ? darkColorScheme : lightColorScheme),
            home: LoginPage(),
            routes: <String, WidgetBuilder>{
              '/home': (BuildContext context) => const HomePage(),
              '/settings': (BuildContext context) => const SettingsPage(),
              '/login': (BuildContext context) => LoginPage(),
            },
          );
        }));
  }
}
