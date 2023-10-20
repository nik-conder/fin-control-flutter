import 'package:fin_control/data/models/profile.dart';
import 'package:fin_control/domain/bloc/profile/list/profile_list_bloc.dart';
import 'package:fin_control/domain/bloc/profile/list/profile_list_event.dart';
import 'package:fin_control/domain/bloc/session/session_bloc.dart';
import 'package:fin_control/domain/bloc/session/session_event.dart';
import 'package:fin_control/presentation/ui/info_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';

class ProfilesList extends StatefulWidget {
  final Profile? selectProfile;

  const ProfilesList({Key? key, this.selectProfile}) : super(key: key);

  @override
  State<ProfilesList> createState() => _ProfilesListState();
}

class _ProfilesListState extends State<ProfilesList> {
  late Profile? _selectedProfile;
  final EdgeInsetsGeometry padding = const EdgeInsets.all(8);

  @override
  void initState() {
    super.initState();
    _selectedProfile = widget.selectProfile;
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final profileListBloc = BlocProvider.of<ProfileListBloc>(context);

    return Column(
      children: [
        Row(children: [
          StreamBuilder(
            stream:
                profileListBloc.profilesStream, // FIXME: not auto refreshing
            builder:
                (BuildContext context, AsyncSnapshot<List<Profile>> snapshot) {
              if (snapshot.hasData) {
                final screenHeight = MediaQuery.of(context).size.height;
                final maxItemCount = (screenHeight / 80).ceil();

                return SizedBox(
                    height: screenHeight * 0.3,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: ListView.builder(
                        padding: const EdgeInsets.all(4),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.length > maxItemCount
                            ? maxItemCount
                            : snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final profile = snapshot.data![index];

                          return ListTile(
                            dense: true,
                            selected: (_selectedProfile == profile),
                            selectedTileColor:
                                Theme.of(context).colorScheme.primaryContainer,
                            selectedColor: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                            mouseCursor: MouseCursor.uncontrolled,
                            title: Text(profile.name),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            titleTextStyle:
                                Theme.of(context).textTheme.titleLarge,
                            visualDensity: VisualDensity.standard,
                            onTap: () {
                              setState(() {
                                _selectedProfile = profile;
                              });
                            },
                            subtitle: Text(profile.currency.name),
                            trailing: IconButton(
                              color:
                                  Theme.of(context).textTheme.bodyMedium?.color,
                              onPressed: () {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        showCloseIcon: true,
                                        content: Text(
                                          localization.in_development,
                                        )));
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          );
                        },
                      ),
                    ));
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Center(
                  child: InfoContent(pageType: InfoPageType.notProfile),
                );
              }
            },
          )
        ]),
        Row(
          children: [
            Padding(
                padding: padding,
                child: IconButton(
                    onPressed: () {
                      profileListBloc.add(UpdateProfilesListEvent());
                    },
                    icon: const Icon(Icons.refresh))),
            Padding(
                padding: padding,
                child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login/create_profile');
                    },
                    child: Text(localization.title_new_profile))),
            if (_selectedProfile != null)
              Padding(
                  padding: padding,
                  child: TextButton(
                      onPressed: () {
                        BlocProvider.of<SessionBloc>(context)
                            .add(SessionCreateEvent(_selectedProfile!));
                        Navigator.pushReplacementNamed(context, '/home',
                            arguments: {'profile': _selectedProfile});
                      },
                      child: Text(localization.next)))
          ],
        )
      ],
    );
  }
}
