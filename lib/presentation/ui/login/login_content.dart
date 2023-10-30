import 'package:fin_control/presentation/ui/profile/profiles_list.dart';
import 'package:flutter/material.dart';

class LoginContent extends StatelessWidget {
  const LoginContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: ProfilesList(),
    );
  }
}
