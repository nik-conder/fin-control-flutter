import 'dart:math';

import 'package:fin_control/data/models/profile.dart';
import 'package:fin_control/domain/bloc/profile/profile_bloc.dart';
import 'package:fin_control/domain/bloc/profile/profile_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class HomeHead extends StatelessWidget {
  final Profile profile;

  final ProfileBloc profileBloc = GetIt.instance<ProfileBloc>();

  HomeHead({super.key, required this.profile});

  final Random random = Random();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
            child: Container(
              padding: const EdgeInsets.all(12),
              color: Theme.of(context).colorScheme.inversePrimary,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StreamBuilder<double>(
                        stream: context.read<ProfileBloc>().balanceStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            double? data = snapshot.data;
                            return Text('Received data: $data');
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                          return const CircularProgressIndicator();
                        },
                      ),
                      IconButton(
                          enableFeedback: false,
                          onPressed: () {
                            BlocProvider.of<ProfileBloc>(context)
                                .add(UpdateBalance(1, random.nextDouble()));
                          },
                          icon: Icon(Icons.add))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("Profile name: ${profile.name}")],
                  )
                ],
              ),
            ));
      },
    );
  }
}
