import 'package:fin_control/domain/bloc/profile/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileInfoBloc extends StatelessWidget {
  const ProfileInfoBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Container(
            color: Theme.of(context).colorScheme.background,
            child: Center(
                child: Row(children: [
              Column(
                children: [
                  Text(
                    'Profile id: ${state.id}',
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'name: ${state.name}',
                  )
                ],
              ),
              Column(
                children: [
                  OutlinedButton(
                      onPressed: () {
                        BlocProvider.of<ProfileBloc>(context)
                            .add(CreateProfileEvent(name: 'profile #1'));
                      },
                      child: const Text('Create profile'))
                ],
              )
            ])));
      },
    );
  }
}
