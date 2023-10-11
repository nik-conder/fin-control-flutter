import 'package:fin_control/data/models/profile.dart';
import 'package:fin_control/data/repository/profiles_repository.dart';
import 'package:fin_control/domain/bloc/profile/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

class ProfilesListOne extends StatelessWidget {
  ProfilesListOne({super.key});

  final profileBloc = GetIt.instance<ProfileBloc>();
  final ProfilesRepository profilesRepository =
      GetIt.instance<ProfilesRepository>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Profile>>(
        stream: profileBloc.notes,
        builder: (context, snapshot) {
          if (snapshot.data != null &&
              snapshot.hasData &&
              snapshot.data!.isNotEmpty) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final profile = snapshot.data![index];
                  return Text(profile.name);
                });
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
