import 'package:fin_control/data/models/profile.dart';
import 'package:fin_control/domain/bloc/profile/profile_bloc.dart';
import 'package:fin_control/domain/bloc/profile/profile_event.dart';
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
  final SessionBloc sessionBloc = GetIt.instance<SessionBloc>();
  final scrollControllerList = ScrollController();
  late ProfileBloc _profileListBloc;

  @override
  void initState() {
    super.initState();
    _profileListBloc = BlocProvider.of<ProfileBloc>(context);

    _profileListBloc.add(UpdateProfilesListEvent());
    _selectedProfile = widget.selectProfile;
    sessionBloc.add(SessionGetEvent());
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          StreamBuilder(
            stream:
                _profileListBloc.profilesStream, // FIXME: not auto refreshing
            builder:
                (BuildContext context, AsyncSnapshot<List<Profile>> snapshot) {
              if (snapshot.hasData) {
                final screenHeight = MediaQuery.of(context).size.height;
                final maxItemCount = (screenHeight / 80).ceil();

                return SizedBox(
                  height: screenHeight * 0.3,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(4),
                    shrinkWrap: true,
                    controller: scrollControllerList,
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.length > maxItemCount
                        ? maxItemCount
                        : snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final profile = snapshot.data![index];

                      return ListTile(
                        isThreeLine: true,
                        key: ValueKey(profile.id),
                        //dense: true,
                        selected: (_selectedProfile == profile),
                        selectedTileColor: colorScheme.primaryContainer,
                        selectedColor: colorScheme.onPrimaryContainer,
                        mouseCursor: MouseCursor.uncontrolled,
                        title: Text(profile.name),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        titleTextStyle: Theme.of(context).textTheme.titleMedium,
                        visualDensity: VisualDensity.standard,
                        onTap: () {
                          setState(() {
                            _selectedProfile = profile;
                          });
                        },
                        subtitle: Text(profile.currency.name),
                        trailing: IconButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                showCloseIcon: true,
                                content: Text(
                                  localization.in_development,
                                )));
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Padding(padding: EdgeInsets.only(top: 8)),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('${localization.error}: ${snapshot.error}');
              } else {
                return const Center(
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
                      _profileListBloc.add(UpdateProfilesListEvent());
                    },
                    icon: const Icon(Icons.refresh))),
            Padding(
                padding: padding,
                child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login/create_profile');
                    },
                    child: Text(localization.new_profile))),
            Padding(
                padding: padding,
                child: TextButton(
                    onPressed: () {
                      _profileListBloc.add(CreateDemoProfileEvent());
                    },
                    child: Text("Demo"))),
            if (_selectedProfile != null)
              Padding(
                  padding: padding,
                  child: TextButton(
                      onPressed: () {
                        sessionBloc.add(SessionCreateEvent(_selectedProfile!));
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
