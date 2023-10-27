import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum InfoPageType { notProfile, loading, noData, hiddenBalance }

class InfoContent extends StatelessWidget {
  final InfoPageType pageType;

  const InfoContent({super.key, required this.pageType});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    const EdgeInsetsGeometry padding = EdgeInsets.all(8);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
              padding: padding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  switch (pageType) {
                    InfoPageType.notProfile => Text(localization.not_profile,
                        style: Theme.of(context).textTheme.headlineSmall),
                    InfoPageType.loading => Text(localization.loading,
                        style: Theme.of(context).textTheme.headlineSmall),
                    InfoPageType.noData => Text(localization.no_data,
                        style: Theme.of(context).textTheme.headlineSmall),
                    InfoPageType.hiddenBalance => Text(
                        localization.hidden_balance,
                        style: Theme.of(context).textTheme.headlineSmall)
                  }
                ],
              )),
          Padding(
              padding: padding,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                switch (pageType) {
                  InfoPageType.notProfile => Text("\uD83E\uDD14",
                      style: Theme.of(context).textTheme.headlineLarge),
                  InfoPageType.loading => Text("\uD83D\uDD5B",
                      style: Theme.of(context).textTheme.headlineLarge),
                  InfoPageType.noData => Text("\uD83E\uDEE5",
                      style: Theme.of(context).textTheme.headlineLarge),
                  InfoPageType.hiddenBalance => Text("\uD83E\uDEEB",
                      style: Theme.of(context).textTheme.headlineLarge)
                }
              ])),
          Padding(
              padding: padding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  switch (pageType) {
                    InfoPageType.notProfile => Text(
                        localization.create_new_profile,
                        style: Theme.of(context).textTheme.bodyLarge),
                    InfoPageType.loading => Text(localization.wait),
                    InfoPageType.noData => Text(localization.no_data),
                    InfoPageType.hiddenBalance =>
                      Text(localization.data_is_hidden_description)
                  }
                ],
              )),
          Padding(
              padding: padding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  switch (pageType) {
                    InfoPageType.notProfile => Container(),
                    // InfoPageType.notProfile => OutlinedButton(
                    //     onPressed: () {
                    //       Navigator.pushNamed(context, '/login/create_profile');
                    //     },
                    //     child: Text(localization.title_new_profile)),
                    InfoPageType.loading => Container(),
                    InfoPageType.noData => Container(),
                    InfoPageType.hiddenBalance => Container(),
                  }
                ],
              )),
        ],
      ),
    );
  }
}
