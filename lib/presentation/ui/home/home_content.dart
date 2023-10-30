import 'dart:io';
import 'package:fin_control/presentation/ui/components/box_page_component.dart';
import 'package:fin_control/presentation/ui/components/box_tip_component.dart';
import 'package:fin_control/presentation/ui/components/transactions_list_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  String getPlathorm() {
    if (Platform.isAndroid) {
      return 'Android';
    } else if (Platform.isIOS) {
      return 'iOS';
    } else if (Platform.isMacOS) {
      return 'MacOS';
    } else if (Platform.isWindows) {
      return 'Windows';
    } else if (Platform.isLinux) {
      return 'Linux';
    } else {
      return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BoxTipComponent(),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BoxContentComponent(
              paddingContent: const EdgeInsets.all(16),
              header: localization.feed,
              content: const TransactionsListComponent(),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Text('Created by ${getPlathorm()}'),
              ),
            ),
          ],
        )
      ],
    );
  }
}
