import 'package:fin_control/config.dart';
import 'package:fin_control/core/di/dependencies_injection.dart';
import 'package:fin_control/domain/bloc/profile/profile_bloc.dart';
import 'package:fin_control/domain/bloc/session/session_bloc.dart';
import 'package:fin_control/domain/bloc/theme/theme_bloc.dart';
import 'package:fin_control/domain/bloc/theme/theme_event.dart';
import 'package:fin_control/domain/bloc/theme/theme_state.dart';
import 'package:fin_control/domain/bloc/token/token_bloc.dart';
import 'package:fin_control/domain/bloc/transactions/transactions_bloc.dart';
import 'package:fin_control/presentation/ui/home/btnNavBar.dart';
import 'package:fin_control/presentation/ui/home/home_page.dart';
import 'package:fin_control/presentation/ui/login/login_page.dart';
import 'package:fin_control/presentation/ui/profile/create_profile_page.dart';
import 'package:fin_control/presentation/ui/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'color_schemes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'domain/bloc/session/session_state.dart';

final DependenciesInjection di = DependenciesInjectionImpl();
GetIt getIt = GetIt.instance;

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //final ThemeBloc themeBloc = GetIt.instance<ThemeBloc>();
  final bool is_login = false;

  @override
  void initState() {
    super.initState();
    //themeBloc.add(ThemeInitial());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => getIt<ThemeBloc>()..add(ThemeInitial())),
          BlocProvider(create: (context) => getIt<SessionBloc>()),
          BlocProvider(create: (context) => getIt<ProfileBloc>()),
          BlocProvider(create: (context) => getIt<TransactionsBloc>()),
          BlocProvider(create: (context) => getIt<TokenBloc>())
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
            home: BlocBuilder<SessionBloc, SessionState>(
              builder: (context, state) {
                if (state is SessionLoaded) {
                  return const BtnNavBar();
                } else {
                  return const LoginPage();
                }
              },
            ),
            routes: <String, WidgetBuilder>{
              '/home': (BuildContext context) => const HomePage(),
              '/settings': (BuildContext context) => const SettingsPage(),
              '/login': (BuildContext context) => const LoginPage(),
              '/login/create_profile': (BuildContext context) =>
                  const CreateProfilePage()
            },
          );
        }));
  }
}
