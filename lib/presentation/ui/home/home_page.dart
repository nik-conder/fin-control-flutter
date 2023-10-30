import 'package:fin_control/config.dart';
import 'package:fin_control/data/models/profile.dart';
import 'package:fin_control/data/models/transaction.dart';
import 'package:fin_control/domain/bloc/session/session_bloc.dart';
import 'package:fin_control/domain/bloc/session/session_event.dart';
import 'package:fin_control/domain/bloc/theme/theme_bloc.dart';
import 'package:fin_control/domain/bloc/theme/theme_event.dart';
import 'package:fin_control/domain/bloc/theme/theme_state.dart';
import 'package:fin_control/domain/bloc/transactions/transactions_bloc.dart';
import 'package:fin_control/presentation/ui/home/home_content.dart';
import 'package:fin_control/presentation/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  final _controllerNote = TextEditingController();
  final _controllerAmount = TextEditingController();

  bool _showWidgetInAppBar = false;

  @override
  void initState() {
    currentType = TransactionType.expense;
    _scrollController.addListener(() {
      setState(() {
        _showWidgetInAppBar = _scrollController.position.pixels > 100;
      });
    });
    super.initState();
  }

  Future<void> _showMyDialog() async {
    final localization = AppLocalizations.of(context)!;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Dialog.fullscreen(
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              title: const Text('AlertDialog Title'),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Тип транзакции",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ]),
                      Row(
                        children: [
                          SegmentedButton(
                              segments: const <ButtonSegment<TransactionType>>[
                                ButtonSegment<TransactionType>(
                                    value: TransactionType.expense,
                                    label: Text('Expense')),
                                ButtonSegment<TransactionType>(
                                    value: TransactionType.income,
                                    label: Text('Income')),
                              ],
                              selected: <TransactionType>{
                                currentType
                              },
                              onSelectionChanged:
                                  (Set<TransactionType> newSelection) {
                                currentType = newSelection.first;
                                setState(() {
                                  currentType = newSelection.first;
                                });
                              })
                        ],
                      )
                    ],
                  ),
                ),
                const Divider(
                  indent: 8,
                  endIndent: 8,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Категория",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              "Укажите категорию",
                              style: Theme.of(context).textTheme.bodyMedium,
                            )
                          ]),
                      const Row(
                        children: [],
                      )
                    ],
                  ),
                ),
                const Divider(
                  indent: 8,
                  endIndent: 8,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextField(
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChanged: (value) {
                            setState(() {
                              _controllerAmount.text = value;
                            });
                          },
                          controller: _controllerAmount,
                          decoration: InputDecoration(
                            hintMaxLines: 1,
                            labelText: "Сумма",
                            helperText: "Укажите сумму",
                            border: const OutlineInputBorder(),
                            suffixIcon: (_controllerAmount.text.isNotEmpty)
                                ? Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: IconButton(
                                        icon: const Icon(Icons.clear),
                                        onPressed: () {
                                          setState(() {
                                            _controllerAmount.clear();
                                          });
                                        }))
                                : null,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(
                  indent: 8,
                  endIndent: 8,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              _controllerNote.text = value;
                            });
                          },
                          controller: _controllerNote,
                          decoration: InputDecoration(
                            labelText: "Заметка",
                            helperText: "...",
                            border: const OutlineInputBorder(),
                            suffixIcon: (_controllerNote.text.isNotEmpty)
                                ? Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: IconButton(
                                        icon: const Icon(Icons.clear),
                                        onPressed: () {
                                          setState(() {
                                            _controllerNote.clear();
                                          });
                                        }))
                                : null,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(localization.next),
                        )
                      ],
                    ))
              ],
            ),
          ),
        );
      },
    );
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
                    ),
                  ),
                  Tooltip(
                    message: localization.settings,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/settings',
                            arguments: {'profile': profile});
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
              _showMyDialog();
              // transactionsBloc.add(TransactionAddEvent(FinTransaction(
              //   profileId: 1,
              //   datetime: DateTime.now(),
              //   amount: Decimal.parse('123'),
              //   type: TransactionType.income,
              //   category: 'category',
              // )));
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
