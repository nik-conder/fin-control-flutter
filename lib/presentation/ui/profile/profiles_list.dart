import 'package:fin_control/data/models/profile.dart';
import 'package:fin_control/domain/bloc/profile/profile_bloc.dart';
import 'package:fin_control/domain/bloc/profile/profile_event.dart';
import 'package:fin_control/domain/bloc/session/session_bloc.dart';
import 'package:fin_control/domain/bloc/session/session_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../utils/utils.dart';
import '../info_content.dart';

class ProfilesList extends StatefulWidget {
  const ProfilesList({Key? key}) : super(key: key);

  @override
  State<ProfilesList> createState() => _ProfilesListState();
}

class _ProfilesListState extends State<ProfilesList> {
  late Profile? _selectedProfile;
  final EdgeInsetsGeometry padding = const EdgeInsets.all(8);

  final scrollControllerList = ScrollController();
  late ProfileBloc _profileListBloc;
  late SessionBloc _sessionBloc;

  @override
  void initState() {
    super.initState();

    _sessionBloc = BlocProvider.of<SessionBloc>(context);
    _selectedProfile = null; // FIXME

    _profileListBloc = BlocProvider.of<ProfileBloc>(context);
    _profileListBloc.add(GetListProfiles());
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(padding: padding),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ListProfilesLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is ListProfilesError) {
                    return const Center(
                      child: InfoContent(InfoPageType.notProfile),
                    );
                  } else if (state is ListProfilesSuccess) {
                    final screenHeight = MediaQuery.of(context).size.height;
                    final maxItemCount = (screenHeight / 80).ceil();
                    final profilesList = state.profiles;
                    return IntrinsicHeight(
                      child: SizedBox(
                        height: screenHeight *
                            0.5, // Ограничиваем высоту контейнера
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Column(
                          children: [
                            Text(
                              localization.select_profile,
                              style: textTheme.headlineSmall,
                            ),
                            Padding(padding: padding),
                            Expanded(
                              child: ListView.separated(
                                padding: const EdgeInsets.all(4),
                                shrinkWrap:
                                    false, 
                                controller: scrollControllerList,
                                scrollDirection: Axis.vertical,
                                itemCount: profilesList!.length > maxItemCount
                                    ? maxItemCount
                                    : profilesList!.length,
                                itemBuilder: (context, index) {
                                  final profile = profilesList[index];

                                  return ListTile(
                                    key: ValueKey(profile.id),
                                    selected: _selectedProfile == profile,
                                    selectedTileColor:
                                        _selectedProfile == profile
                                            ? colorScheme.primaryContainer
                                            : colorScheme.onPrimaryContainer,
                                    selectedColor: _selectedProfile == profile
                                        ? colorScheme.onPrimaryContainer
                                        : colorScheme.primaryContainer,
                                    mouseCursor: MouseCursor.uncontrolled,
                                    title: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            child: Container(
                                              color: _selectedProfile == profile
                                                  ? colorScheme.onSecondary
                                                  : colorScheme
                                                      .primaryContainer,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 4),
                                                child: Text(
                                                  Utils.getFormattedCurrency(
                                                      profile.currency),
                                                  style: textTheme.titleSmall,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            profile.name,
                                            softWrap: true,
                                            style: textTheme.titleSmall,
                                          ),
                                        ),
                                      ],
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    titleTextStyle: textTheme.titleMedium,
                                    visualDensity: VisualDensity.standard,
                                    onTap: () {
                                      setState(() {
                                        _selectedProfile = profile;
                                      });
                                    },
                                    trailing: IconButton(
                                      onPressed: () {
                                        _profileListBloc
                                            .add(DeleteProfile(profile));
                                      },
                                      icon: const Icon(Icons.delete),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const Padding(
                                  padding: EdgeInsets.only(top: 8),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Text('Error');
                  }
                },
              )
            ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
                    child: const Text("Demo"))),
            if (_selectedProfile != null)
              Padding(
                  padding: padding,
                  child: TextButton(
                      onPressed: () {
                        _sessionBloc.add(SessionCreateEvent(_selectedProfile!));
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
