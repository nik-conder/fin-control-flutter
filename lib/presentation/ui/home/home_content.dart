import 'package:fin_control/presentation/ui/components/box_page_component.dart';
import 'package:fin_control/presentation/ui/components/box_tip_component.dart';
import 'package:fin_control/presentation/ui/components/transactions_list_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Row(
          children: [BoxTipComponent()],
        ),
        Row(
          children: [
            Expanded(
                child: BoxContentComponent(
                    paddingContent: const EdgeInsets.all(16),
                    header: localization.feed,
                    content: const TransactionsListComponent()))
          ],
        )
      ],
    );
  }
}
