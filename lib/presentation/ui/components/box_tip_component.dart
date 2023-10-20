import 'dart:async';
import 'dart:math';
import 'package:fin_control/presentation/ui/components/box_page_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BoxTipComponent extends StatefulWidget {
  const BoxTipComponent({super.key});

  @override
  State<BoxTipComponent> createState() => _BoxTipComponentState();
}

class _BoxTipComponentState extends State<BoxTipComponent> {
  late Timer _timer;
  late Random random;
  late int currentTip;
  late Map<String, String> tips;
  final int updateTimeSeconds = 60;

  _getRandom(int currentTip) {
    final int result = random.nextInt(4);
    if (result == currentTip) _getRandom(result);
    return result;
  }

  @override
  void initState() {
    super.initState();

    random = Random();
    currentTip = _getRandom(0);
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: updateTimeSeconds), (timer) {
      setState(() {
        currentTip = _getRandom(currentTip);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    tips = {
      localization.advice_title_1: localization.advice_description_1,
      localization.advice_title_2: localization.advice_description_2,
      localization.advice_title_3: localization.advice_description_3,
      localization.advice_title_4: localization.advice_description_4,
      localization.advice_title_5: localization.advice_description_5
    };
    return Expanded(
      child: BoxContentComponent(
          paddingContent: const EdgeInsets.all(16),
          header: "Полезные советы",
          icon: const Icon(Icons.info_outline),
          content: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: Text(tips.keys.elementAt(currentTip),
                          style: Theme.of(context).textTheme.titleMedium))
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    tips.values.elementAt(currentTip),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ))
                ],
              )
            ],
          )),
    );
  }
}
