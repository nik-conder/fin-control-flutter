import 'package:fin_control/presentation/ui/settings/settings_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.title_settings),
      ),
      body: const Center(
        child: SettingsContent(),
      ),
    );
  }
}
