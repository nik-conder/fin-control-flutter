import 'dart:math';

import 'package:fin_control/domain/bloc/profile/profile_bloc.dart';
import 'package:fin_control/domain/bloc/profile/profile_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeHead extends StatelessWidget {
  final Random random = Random();

  HomeHead({Key? key}) : super(key: key);

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
                          final data = snapshot.data;
                          if (data != null) {
                            String formattedBalance = data.toStringAsFixed(2);
                            return Text(
                              'Balance: $formattedBalance',
                              style: Theme.of(context).textTheme.headlineSmall,
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                      IconButton(
                          onPressed: () {
                            BlocProvider.of<ProfileBloc>(context).add(
                                UpdateBalance(1, random.nextDouble() * 1024));
                          },
                          icon: Icon(Icons.add))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("Profile name: ")],
                  )
                ],
              ),
            ));
      },
    );
  }
}
