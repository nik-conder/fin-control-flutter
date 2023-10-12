import 'package:fin_control/data/models/profile.dart';
import 'package:fin_control/domain/bloc/profile/list/profile_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ProfilesList extends StatelessWidget {
  ProfilesList({super.key});

  final profileListBloc = GetIt.instance<ProfileListBloc>();

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StreamBuilder(
              stream: profileListBloc.profileListStream,
              builder: (BuildContext context,
                  AsyncSnapshot<List<Profile>> snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else if (snapshot.hasData) {
                  return Expanded(
                      child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final profile = snapshot.data![index];
                            if (snapshot.data == null) {
                              return const Text("No data");
                            } else {
                              return ListTile(
                                title: Text(profile.name),
                                subtitle: Text(profile.id.toString()),
                                trailing: IconButton(
                                  onPressed: () {
                                    //profileListBloc.add(DeleteProfile(profile.id));
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                              );
                            }
                          }));
                } else {
                  return const CircularProgressIndicator();
                }
              })
        ]);
  }
}
