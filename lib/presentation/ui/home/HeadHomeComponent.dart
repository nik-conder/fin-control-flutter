import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HeadHomeComponent extends StatelessWidget {
  final double balance;
  final bool balanceIsVisibile;
  final void Function() onPressed;
  final void Function() onBalanceIsVisibile;

  HeadHomeComponent(
      {required this.balance,
      required this.onPressed,
      required this.onBalanceIsVisibile,
      required this.balanceIsVisibile});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(50),
        bottomRight: Radius.circular(50),
      ),
      child: Container(
          padding: const EdgeInsets.all(12),
          color: Colors.green,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    '${(balanceIsVisibile) ? '\$' + balance.toStringAsFixed(2) : '🤑 🤑 🤑'}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  )
                ],
              ),
              Column(children: [
                Tooltip(
                  message: (balanceIsVisibile) ? 'Скрыть' : 'Показать',
                  child: IconButton(
                    onPressed: onBalanceIsVisibile,
                    icon: (balanceIsVisibile)
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off),
                  ),
                ),
              ]),
              Column(
                children: [
                  Tooltip(
                    message: 'Добавить',
                    child: IconButton(
                      onPressed: onPressed,
                      icon: const Icon(Icons.add),
                    ),
                  ),
                ],
              ),
              Column(children: [
                IconButton(
                    onPressed: onPressed, icon: const Icon(Icons.remove)),
              ])
            ],
          )),
    );
  }
}
