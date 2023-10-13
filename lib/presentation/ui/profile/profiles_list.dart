import 'package:fin_control/data/models/profile.dart';
import 'package:fin_control/domain/bloc/profile/list/profile_list_bloc.dart';
import 'package:fin_control/domain/bloc/profile/list/profile_list_event.dart';
import 'package:fin_control/domain/bloc/profile/list/profile_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ProfilesList extends StatelessWidget {
  ProfilesList({super.key});

  final profileListBloc = GetIt.instance<ProfileListBloc>();

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder(
                  bloc: profileListBloc,
                  builder: (context, state) {
                    if (state is ProfileSelected) {
                      return Row(
                        children: [
                          Text("Выбран профиль: ${state.profile.name}"),
                          OutlinedButton(
                              onPressed: () {
                                profileListBloc.add(Login(state.profile));
                                Navigator.pushReplacementNamed(
                                    context, '/home');
                              },
                              child: Text("Продолжить")),
                        ],
                      );
                    } else {
                      return Text("Профиль ещё не выбран");
                    }
                  }),
            ],
          ),
          Row(
            children: [
              StreamBuilder(
                  stream: profileListBloc.profileListStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Profile>> snapshot) {
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else if (snapshot.hasData) {
                      final screenHeight = MediaQuery.of(context).size.height;
                      final maxItemCount = (screenHeight / 80)
                          .ceil(); // Определение максимального количества элементов в списке на основе высоты экрана

                      return SizedBox(
                          height: screenHeight * 0.3,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.separated(
                              padding: const EdgeInsets.all(8),
                              scrollDirection: Axis.vertical,
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length > maxItemCount
                                  ? maxItemCount
                                  : snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final profile = snapshot.data![index];
                                if (snapshot.data == null) {
                                  return const Text("No data");
                                } else {
                                  return ElementProfilesList(
                                    profile: profile,
                                    onTap: () {
                                      profileListBloc
                                          .add(SelectProfile(profile));
                                    },
                                  );
                                }
                              }));
                    } else {
                      return const CircularProgressIndicator();
                    }
                  })
            ],
          )
        ]);
  }
}

class ElementProfilesList extends StatelessWidget {
  final Profile profile;
  final GestureTapCallback? onTap;
  final bool isSelected;

  const ElementProfilesList(
      {required this.profile,
      required this.onTap,
      this.isSelected = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
        //profileListBloc
        //  .add(SelectProfile(profile));
      },
      child: ListTile(
        tileColor: (isSelected) ? Colors.red : null,
        textColor: (isSelected) ? Colors.green : null,
        title: Text(profile.name),
        subtitle: Text(profile.id.toString()),
        trailing: IconButton(
          onPressed: () {
            // Delete the profile on button click
            //profileListBloc.add(DeleteProfile(profile.id));
          },
          icon: const Icon(Icons.delete),
        ),
      ),
    );
  }
}
