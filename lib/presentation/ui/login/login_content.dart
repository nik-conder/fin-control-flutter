import 'package:fin_control/data/models/session.dart';
import 'package:fin_control/domain/bloc/profile/list/profile_list_bloc.dart';
import 'package:fin_control/domain/bloc/profile/list/profile_list_state.dart';
import 'package:fin_control/domain/bloc/session/session_bloc.dart';
import 'package:fin_control/domain/bloc/session/session_event.dart';
import 'package:fin_control/presentation/ui/profile/create_profile_content.dart';
import 'package:fin_control/presentation/ui/profile/profiles_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class LoginContent extends StatelessWidget {
  final sessionBloc = GetIt.instance<SessionBloc>();

  LoginContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          StreamBuilder(
              stream: sessionBloc.session,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data.toString());
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  return Text('пусто ${snapshot.data.toString()}');
                }
              }),
          Row(
            children: [
              OutlinedButton(
                  onPressed: () {
                    BlocProvider.of<SessionBloc>(context)
                        .add(SessionCreateEvent(Session(profileId: 1)));
                  },
                  child: Text("Login")),
              OutlinedButton(
                  onPressed: () {
                    BlocProvider.of<SessionBloc>(context)
                        .add(SessionDeleteEvent());
                  },
                  child: Text("Delete")),
            ],
          ),
          CreateProfileContent(),
          ProfilesList(),
        ],
      ),
    );
  }
}
