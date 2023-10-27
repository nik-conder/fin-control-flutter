import 'package:fin_control/domain/bloc/session/session_bloc.dart';
import 'package:fin_control/presentation/ui/profile/profiles_list.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class LoginContent extends StatelessWidget {
  final sessionBloc = GetIt.instance<SessionBloc>();

  LoginContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: ProfilesList(),
              )
            ],
          )
        ],
      ),
    );
  }
}
