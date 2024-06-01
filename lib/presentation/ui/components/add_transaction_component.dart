import 'package:decimal/decimal.dart';
import 'package:fin_control/config.dart';
import 'package:fin_control/data/models/transaction.dart';
import 'package:fin_control/domain/bloc/transactions/transactions_bloc.dart';
import 'package:fin_control/domain/bloc/transactions/transactions_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddTransactionComponent extends StatefulWidget {
  const AddTransactionComponent({Key? key}) : super(key: key);

  @override
  State<AddTransactionComponent> createState() =>
      _AddTransactionComponentState();
}

class _AddTransactionComponentState extends State<AddTransactionComponent> {
  final _controllerNote = TextEditingController();
  final _controllerAmount = TextEditingController();
  late TransactionType currentType;

  late List<String> listCategories;
  late String currentCategory;

  @override
  void initState() {
    listCategories = ['One', 'Two', 'Three', 'Four'];
    currentCategory = listCategories.first;

    currentType = TransactionType.expense;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final transactionsBloc = BlocProvider.of<TransactionsBloc>(context);

    return Dialog.fullscreen(
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: const Text('Add transaction'),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: (_controllerNote.text.isNotEmpty &&
                          _controllerAmount.text.isNotEmpty &&
                          currentCategory.isNotEmpty)
                      ? () {
                          transactionsBloc.add(
                            TransactionAddEvent(
                              FinTransaction(
                                  profileId: 1, // FIXME
                                  type: currentType,
                                  amount: Decimal.parse(_controllerAmount.text),
                                  datetime: DateTime.now(),
                                  category: currentCategory,
                                  note: _controllerNote.text),
                            ),
                          );
                          Navigator.of(context).pop();
                        }
                      : null,
                  child: const Row(
                    children: [Icon(Icons.add), Text("Add")],
                  ),
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Тип транзакции",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ]),
                      ),
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
                              showSelectedIcon: false,
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
                  thickness: 0.4,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Column(
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
                      ),
                      DropdownMenu<String>(
                        width: MediaQuery.of(context).size.width * 0.5,
                        initialSelection: currentCategory,
                        enableSearch: false,
                        onSelected: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            currentCategory = value!;
                          });
                        },
                        dropdownMenuEntries: listCategories
                            .map<DropdownMenuEntry<String>>((String value) {
                          return DropdownMenuEntry<String>(
                              value: value, label: value);
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  indent: 8,
                  endIndent: 8,
                  thickness: 0.4,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Сумма",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                "Укажите сумму",
                                style: Theme.of(context).textTheme.bodyMedium,
                              )
                            ]),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: TextField(
                          maxLength: TransactionsLimits.maxAmountChar,
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
                  thickness: 0.4,
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
                          maxLength: TransactionsLimits.maxNoteChar,
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
              ],
            ),
          )),
    );
  }
}
