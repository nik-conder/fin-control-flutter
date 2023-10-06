import 'package:fin_control/Config.dart';
import 'package:fin_control/DBFactory.dart';
import 'package:fin_control/DependencyInjector.dart';
import 'package:fin_control/domain/DarkModeUseCase.dart';
import 'package:fin_control/presentation/bloc/home_bloc.dart';
import 'package:fin_control/presentation/bloc/theme_bloc.dart';
import 'package:fin_control/presentation/bloc/theme_state.dart';
import 'package:fin_control/presentation/ui/home/HomePage.dart';
import 'package:fin_control/presentation/ui/settings/SettingsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

void main() {
  //DBFactory.setup();
  DependencyInjector.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final darkModeUseCase = GetIt.instance<DarkModeUseCase>();
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ThemeBloc(darkModeUseCase)),
          BlocProvider(create: (context) => HomeBloc()),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
          return MaterialApp(
            title: GeneralConfig.appName,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              brightness: state.isDarkMode ? Brightness.dark : Brightness.light,
              useMaterial3: true,
            ),
            home: const HomePage(),
            routes: <String, WidgetBuilder>{
              '/settings': (BuildContext context) => const SettingsPage(),
            },
          );
        }));
  }
}
