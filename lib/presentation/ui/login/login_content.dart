import 'package:fin_control/presentation/ui/profile/create_profile_content.dart';
import 'package:fin_control/presentation/ui/profile/profiles_list.dart';
import 'package:flutter/material.dart';

class LoginContent extends StatelessWidget {
  const LoginContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          CreateProfileContent(),
          const Text("или выберите другой"),
          Container(
            padding: const EdgeInsets.all(12),
            color: Theme.of(context).colorScheme.inversePrimary,
            child: Column(children: [
              Text("List #1", style: Theme.of(context).textTheme.headlineSmall),
              ProfilesListOne(),
            ]),
          ),
        ],
      ),
    );
  }
}
