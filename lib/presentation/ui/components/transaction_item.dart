import 'package:fin_control/data/models/transaction.dart';
import 'package:fin_control/domain/bloc/transactions/transactions_bloc.dart';
import 'package:fin_control/domain/bloc/transactions/transactions_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../utils/utils.dart';

class TransactionItem extends StatefulWidget {
  final FinTransaction transaction;

  const TransactionItem({Key? key, required this.transaction})
      : super(key: key);

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final transaction = widget.transaction;
    final localization = AppLocalizations.of(context)!;

    return InkWell(
      radius: 20,
      onLongPress: () {
        Scaffold.of(context).showBottomSheet(
            elevation: 0,
            (context) => Container(
                padding: const EdgeInsets.all(36),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Text(
                          localization.select_action,
                          style: textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    constraints: const BoxConstraints(maxHeight: 150),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              ListTile(
                                title: Row(
                                  children: [
                                    const Padding(
                                        padding: EdgeInsets.only(right: 8),
                                        child: Icon(Icons.edit)),
                                    Text(localization.edit)
                                  ],
                                ),
                                onTap: () {
                                  // TODO
                                },
                              ),
                              ListTile(
                                textColor: colorScheme.error,
                                title: Row(children: [
                                  const Padding(
                                      padding: EdgeInsets.only(right: 8),
                                      child: Icon(Icons.delete)),
                                  Text(localization.delete)
                                ]),
                                onTap: () {
                                  BlocProvider.of<TransactionsBloc>(context)
                                      .add(TransactionDeleteEvent(transaction));
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.close)),
                        ),
                      ],
                    ),
                  )
                ])));
      },
      child: ClipRRect(
        clipBehavior: Clip.hardEdge,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: (transaction.type == TransactionType.income)
                  ? colorScheme.primary
                  : colorScheme.error,
              width: 2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 12, right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Column(children: [
                        Text(
                          transaction.amount.toStringAsFixed(3),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: (transaction.type == TransactionType.income)
                                ? colorScheme.primary
                                : colorScheme.error,
                          ),
                        ),
                      ]),
                    ),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              left: 8, top: 4, right: 8, bottom: 4),
                          decoration: BoxDecoration(
                            color: (transaction.type == TransactionType.income)
                                ? colorScheme.primary
                                : colorScheme.error,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(transaction.category.toString(),
                              style: TextStyle(
                                color: colorScheme.onPrimary,
                              )),
                        )
                      ],
                    )
                  ],
                ),
              ),
              if (transaction.note != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 12, right: 12),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(transaction.note.toString()),
                      ]),
                ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8, left: 12, right: 12, bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('#${transaction.id}')],
                    ),
                    Flexible(
                        child: Column(
                      children: [
                        Text(
                          Utils.getFormattedDate(transaction.datetime),
                          style: TextStyle(color: colorScheme.onBackground),
                        ),
                      ],
                    ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
