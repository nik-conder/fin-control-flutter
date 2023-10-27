import 'package:fin_control/presentation/ui/components/box_page_component.dart';
import 'package:fin_control/presentation/ui/components/box_tip_component.dart';
import 'package:fin_control/presentation/ui/components/transactions_list_component.dart';
import 'package:flutter/material.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [BoxTipComponent()],
        ),
        Row(
          children: [
            Expanded(
                child: BoxContentComponent(
                    paddingContent: EdgeInsets.all(16),
                    header: "Лента",
                    content: TransactionsListComponent()))
          ],
        )
      ],
    );
  }
}
