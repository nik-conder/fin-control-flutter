import 'package:decimal/decimal.dart';
import 'package:fin_control/config.dart';
import 'package:fin_control/data/models/profile.dart';
import 'package:fin_control/data/models/transaction.dart';
import 'package:fin_control/domain/bloc/session/session_bloc.dart';
import 'package:fin_control/domain/bloc/session/session_event.dart';
import 'package:fin_control/domain/bloc/theme/theme_bloc.dart';
import 'package:fin_control/domain/bloc/theme/theme_event.dart';
import 'package:fin_control/domain/bloc/theme/theme_state.dart';
import 'package:fin_control/domain/bloc/transactions/transactions_bloc.dart';
import 'package:fin_control/domain/bloc/transactions/transactions_event.dart';
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
  bool _showWidgetInAppBar = false;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _showWidgetInAppBar = _scrollController.position.pixels > 100;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final sessionBloc = BlocProvider.of<SessionBloc>(context);
    final transactionsBloc = BlocProvider.of<TransactionsBloc>(context);
    final themeBloc = BlocProvider.of<ThemeBloc>(context);

    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final Profile profile = args['profile'];

    final localization = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          body: CustomScrollView(
            scrollDirection: Axis.vertical,
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                stretchTriggerOffset: 300.0,
                expandedHeight: 150.0,
                pinned: true,
                floating: true,
                flexibleSpace: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  return FlexibleSpaceBar(
                      background: AnimatedOpacity(
                        opacity: _showWidgetInAppBar ? 0.0 : 1.0,
                        duration: const Duration(milliseconds: 200),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                profile.name,
                                style: theme.textTheme.headlineMedium,
                              ),
                              Text(
                                "${Utils.getFormattedCurrencyToSymbol(profile.currency)} ${profile.balance}",
                                style: theme.textTheme.titleLarge,
                              ),
                            ],
                          ),
                        ),
                      ),
                      titlePadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
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
                                style: theme.textTheme.titleMedium,
                                textAlign: TextAlign.start,
                              ),
                            ),
                            ClipRRect(
                                clipBehavior: Clip.antiAlias,
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 8, top: 4, right: 8, bottom: 4),
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  child: Text(
                                    "${Utils.getFormattedCurrencyToSymbol(profile.currency)} ${profile.balance}",
                                    style: theme.textTheme.titleSmall,
                                  ),
                                ))
                          ],
                        ),
                      ));
                }),
                actions: [
                  Tooltip(
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
                      )),
                  Tooltip(
                    message: localization.settings,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/settings');
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
                      )),
                ],
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return const HomeContent();
                  },
                  childCount: 1,
                ),
              ),
              // SliverAnimatedList(itemBuilder: (context, index, animation) {
              //   return Column(
              //     children: [
              //       HomeHead(profile: profile),
              //       const HomeContent(),
              //       const FootComponent()
              //     ],
              //   );
              // })
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              transactionsBloc.add(TransactionAddEvent(FinTransaction(
                profileId: 1,
                datetime: DateTime.now(),
                amount: Decimal.parse('123'),
                type: TransactionType.income,
                category: 'category',
              )));
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
