import 'package:fin_control/data/models/profile.dart';
import 'package:fin_control/domain/bloc/profile/list/profile_list_bloc.dart';
import 'package:fin_control/domain/bloc/profile/list/profile_list_event.dart';
import 'package:fin_control/domain/bloc/profile/list/profile_list_state.dart';
import 'package:fin_control/domain/bloc/profile/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ProfilesList extends StatelessWidget {
  const ProfilesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              StreamBuilder(
                  stream: context.read<ProfileListBloc>().profilesStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Profile>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData) {
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
                                    const Padding(padding: EdgeInsets.all(8)),
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
                                        Navigator.of(context)
                                            .pushReplacementNamed('/home',
                                                arguments: {
                                              'profile': profile
                                            });
                                      },
                                    );
                                  }
                                }));
                      } else {
                        return const Text("No data");
                      }
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      // Поток находится в режиме ожидания, показать индикатор загрузки, например:
                      return const CircularProgressIndicator();
                    } else {
                      // Обработка других состояний, если необходимо
                      return ErrorWidget('Ошибка при получении данных');
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
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.hardEdge,
        child: Container(
          padding: const EdgeInsets.all(8),
          color: Theme.of(context).colorScheme.inversePrimary,
          child: GestureDetector(
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
          ),
        ));
  }
}
