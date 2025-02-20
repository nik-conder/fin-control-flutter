import 'dart:ui';

import 'package:fin_control/config.dart';
import 'package:fin_control/data/models/profile.dart';
import 'package:fin_control/data/models/transaction.dart';
import 'package:fin_control/domain/bloc/session/session_bloc.dart';
import 'package:fin_control/domain/bloc/session/session_event.dart';
import 'package:fin_control/domain/bloc/theme/theme_bloc.dart';
import 'package:fin_control/domain/bloc/theme/theme_event.dart';
import 'package:fin_control/domain/bloc/theme/theme_state.dart';
import 'package:fin_control/presentation/ui/components/add_transaction_component.dart';
import 'package:fin_control/presentation/ui/home/home_content.dart';
import 'package:fin_control/presentation/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();

  late TransactionType currentType;

  bool _showWidgetInAppBar = false;

  final double _appBarHeight = 200.0;
  double _borderRadius = 50.0;

  @override
  void initState() {
    currentType = TransactionType.expense;
    _scrollController.addListener(() {
      setState(() {
        _showWidgetInAppBar = _scrollController.position.pixels > 100;
        _borderRadius =
            _scrollController.offset < _appBarHeight - kToolbarHeight
                ? 50.0
                : 0.0;
      });
    });
    super.initState();
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return const AddTransactionComponent();
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final args =
    //     ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    //final Profile profile = args['profile'];

    final localization = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final sessionBloc = BlocProvider.of<SessionBloc>(context);
    final themeBloc = BlocProvider.of<ThemeBloc>(context);

    return Scaffold(
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            stretchTriggerOffset: 300.0,
            expandedHeight: _appBarHeight,
            pinned: true,
            floating: true,
            flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return FlexibleSpaceBar(
                  background: AnimatedOpacity(
                    opacity: _showWidgetInAppBar ? 0.0 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              colorScheme.primaryContainer,
                              colorScheme.primary,
                            ]),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(_borderRadius),
                          bottomRight: Radius.circular(_borderRadius),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Text(
                          //   profile.name,
                          //   style: textTheme.headlineMedium,
                          // ),
                          // Text(
                          //   "${Utils.getFormattedCurrencyToSymbol(profile.currency)} ${profile.balance}",
                          //   style: textTheme.titleLarge,
                          // )
                        ],
                      ),
                    ),
                  ),
                  titlePadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  title: AnimatedOpacity(
                    opacity: _showWidgetInAppBar ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(
                            GeneralConfig.appName,
                            style: textTheme.titleMedium,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        ClipRRect(
                            clipBehavior: Clip.antiAlias,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 8, top: 4, right: 8, bottom: 4),
                              color: colorScheme.surface,
                              child: ImageFiltered(
                                imageFilter: ImageFilter.blur(
                                  sigmaX: 6.0,
                                  sigmaY: 4.0,
                                ),
                                // child: Text(
                                //   "${Utils.getFormattedCurrencyToSymbol(profile.currency)} ${profile.balance}",
                                //   style: textTheme.titleSmall,
                                // ),
                              ),
                            ))
                      ],
                    ),
                  ));
            }),
            actions: [
              BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
                return Tooltip(
                  message: (state.isDarkMode)
                      ? localization.light_mode
                      : localization.dark_mode,
                  child: IconButton(
                    onPressed: () {
                      themeBloc.add(UpdateThemeEvent());
                    },
                    icon: (state.isDarkMode)
                        ? const Icon(Icons.light_mode_outlined)
                        : const Icon(Icons.dark_mode_outlined),
                  ),
                );
              }),
              Tooltip(
                message: localization.settings,
                child: IconButton(
                  onPressed: () {
                    // Navigator.pushNamed(context, '/settings',
                    //     arguments: {'profile': profile});
                  },
                  icon: const Icon(Icons.settings_outlined),
                ),
              ),
              Tooltip(
                message: localization.logout,
                child: IconButton(
                  onPressed: () {
                    //Navigator.pushReplacementNamed(context, '/login');
                    sessionBloc.add(SessionDeleteEvent());
                    Navigator.popAndPushNamed(context, '/login');
                  },
                  icon: const Icon(Icons.logout_outlined),
                ),
              ),
            ],
            backgroundColor: _showWidgetInAppBar
                ? colorScheme.primaryContainer
                : Colors.transparent,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return const HomeContent();
              },
              childCount: 1,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showMyDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
