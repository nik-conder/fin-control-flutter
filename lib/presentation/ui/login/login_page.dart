import 'package:fin_control/domain/bloc/profile/profile_bloc.dart';
import 'package:fin_control/presentation/ui/login/login_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final profileBloc = GetIt.instance<ProfileBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: BlocProvider(
          create: (context) => profileBloc,
          child: const LoginContent(),
        ));
  }
}
