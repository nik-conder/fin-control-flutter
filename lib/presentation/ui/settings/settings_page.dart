import 'package:fin_control/data/models/profile.dart';
import 'package:fin_control/presentation/ui/settings/settings_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final args =
    //     ModalRoute.of(context)!.settings.arguments as Map<String, Profile>;

    //final Profile profile = args.values.first;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      // body: SingleChildScrollView(
      //   child: SettingsContent(profile: profile),
      // ),
    );
  }
}
