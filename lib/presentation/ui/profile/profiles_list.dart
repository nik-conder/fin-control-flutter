import 'package:fin_control/data/models/profile.dart';
import 'package:fin_control/domain/bloc/profile/list/profile_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilesList extends StatefulWidget {
  final Profile? selectProfile;

  const ProfilesList({Key? key, this.selectProfile}) : super(key: key);

  @override
  State<ProfilesList> createState() => _ProfilesListState();
}

class _ProfilesListState extends State<ProfilesList> {
  late Profile? _selectedProfile;

  @override
  void initState() {
    super.initState();
    _selectedProfile = widget.selectProfile;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Выберите профиль",
                  style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder(
                stream: context.read<ProfileListBloc>().profilesStream,
                builder: (BuildContext context,
                    AsyncSnapshot<List<Profile>> snapshot) {
                  if (snapshot.hasData) {
                    final screenHeight = MediaQuery.of(context).size.height;
                    final maxItemCount = (screenHeight / 80).ceil();

                    return SizedBox(
                      height: screenHeight * 0.3,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(4),
                        itemCount: snapshot.data!.length > maxItemCount
                            ? maxItemCount
                            : snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final profile = snapshot.data![index];
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            clipBehavior: Clip.hardEdge,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              color: profile.id == _selectedProfile?.id
                                  ? Theme.of(context)
                                      .colorScheme
                                      .primaryContainer
                                  : null,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedProfile = profile;
                                  });
                                },
                                child: ListTile(
                                  hoverColor: Colors.red,
                                  mouseCursor: MouseCursor.defer,
                                  title: Text(profile.name),
                                  subtitle: Text(profile.id.toString()),
                                  trailing: IconButton(
                                    onPressed: () {
                                      // код для удаления профиля
                                    },
                                    icon: const Icon(Icons.delete),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Container();
                  }
                },
              )
            ],
          )
        ]);
  }
}
