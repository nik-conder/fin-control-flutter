import 'package:fin_control/config.dart';
import 'package:fin_control/dependency_injector.dart';
import 'package:fin_control/domain/bloc/profile/profile_bloc.dart';
import 'package:fin_control/domain/bloc/session/session_bloc.dart';
import 'package:fin_control/domain/bloc/theme/theme_bloc.dart';
import 'package:fin_control/domain/bloc/theme/theme_event.dart';
import 'package:fin_control/domain/bloc/theme/theme_state.dart';
import 'package:fin_control/domain/bloc/transactions/transactions_bloc.dart';
import 'package:fin_control/presentation/ui/home/home_page.dart';
import 'package:fin_control/presentation/ui/login/login_page.dart';
import 'package:fin_control/presentation/ui/profile/create_profile_page.dart';
import 'package:fin_control/presentation/ui/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'color_schemes.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  DependencyInjector.setup();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final themeBloc = GetIt.instance<ThemeBloc>();

  @override
  void initState() {
    super.initState();
    themeBloc.add(ThemeInitial());
  }

  @override
  Widget build(BuildContext context) {
    final sessionBloc = GetIt.instance<SessionBloc>();
    final profileBloc = GetIt.instance<ProfileBloc>();
    final transactionsBloc = GetIt.instance<TransactionsBloc>();

    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => themeBloc),
          BlocProvider(create: (context) => sessionBloc),
          BlocProvider(create: (context) => profileBloc),
          BlocProvider(create: (context) => transactionsBloc),
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
            home: const LoginPage(),
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
