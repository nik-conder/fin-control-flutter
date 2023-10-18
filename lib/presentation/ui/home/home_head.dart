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

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return SizedBox(
          height: screenHeight * 0.2,
          child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
              child: Container(
                padding: const EdgeInsets.all(12),
                //color: Theme.of(context).colorScheme.inversePrimary,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.inversePrimary,
                      Theme.of(context).colorScheme.primaryContainer
                    ], // Список цветов градиента
                    begin: Alignment.topCenter, // Начальная точка градиента
                    end: Alignment.bottomCenter, // Конечная точка градиента
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(children: [
                          Text(
                            "\$",
                            style: Theme.of(context).textTheme.headlineLarge,
                          )
                        ]),
                        Column(
                          children: [
                            StreamBuilder<double>(
                              stream: context.read<ProfileBloc>().balanceStream,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  double? data = snapshot.data;
                                  return Text(
                                    (data != null)
                                        ? data.toStringAsFixed(2)
                                        : "0.00",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge,
                                  );
                                } else {
                                  return const CircularProgressIndicator();
                                }
                              },
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                                enableFeedback: false,
                                onPressed: () {
                                  BlocProvider.of<ProfileBloc>(context)
                                      .add(UpdateBalance(1, 0)); // todo
                                },
                                icon: Icon(Icons.add))
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Profile name: ${profile.name}"),
                        //Text("selected profile: ${selectedProfile.name}")
                      ],
                    )
                  ],
                ),
              )),
        );
      },
    );
  }
}
