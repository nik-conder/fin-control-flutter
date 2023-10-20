import 'package:fin_control/data/models/currency.dart';
import 'package:fin_control/data/models/profile.dart';
import 'package:fin_control/domain/bloc/profile/profile_bloc.dart';
import 'package:fin_control/domain/bloc/profile/profile_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class HomeHead extends StatefulWidget {
  final Profile profile;

  const HomeHead({super.key, required this.profile});

  @override
  State<HomeHead> createState() => _HomeHeadState();
}

class _HomeHeadState extends State<HomeHead> {
  final profileBloc = GetIt.instance<ProfileBloc>();

  @override
  void initState() {
    super.initState();
    profileBloc.add(UpdateBalance(widget.profile.id!));
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormat = switch (widget.profile.currency) {
      Currency.eur => "€",
      Currency.usd => "\$",
      Currency.rub => "₽",
      _ => "???"
    };

    final screenHeight = MediaQuery.of(context).size.height;
    return BlocBuilder(
      bloc: profileBloc,
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
                        Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: Column(children: [
                              Text(
                                currencyFormat,
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              )
                            ])),
                        Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: Column(
                              children: [
                                StreamBuilder(
                                    stream: profileBloc.balanceStream,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData &&
                                          snapshot.data != null) {
                                        return Text(
                                          snapshot.data!
                                              .toStringAsFixed(2)
                                              .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineLarge,
                                        );
                                      } else {
                                        return const CircularProgressIndicator();
                                      }
                                    })
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                IconButton(
                                    enableFeedback: false,
                                    onPressed: () {
                                      profileBloc.add(ChangeBalance(1, 0));
                                    },
                                    icon: const Icon(Icons.add))
                              ],
                            ))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Profile name: ${widget.profile.name}"),
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
