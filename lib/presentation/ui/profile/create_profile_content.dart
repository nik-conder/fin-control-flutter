import 'package:fin_control/config.dart';
import 'package:fin_control/data/models/currency.dart';
import 'package:fin_control/domain/bloc/profile/list/profile_list_bloc.dart';
import 'package:fin_control/domain/bloc/profile/list/profile_list_event.dart';
import 'package:fin_control/domain/bloc/profile/profile_bloc.dart';
import 'package:fin_control/domain/bloc/profile/profile_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateProfileContent extends StatefulWidget {
  const CreateProfileContent({Key? key}) : super(key: key);

  @override
  State<CreateProfileContent> createState() => _CreateProfileContentState();
}

class _CreateProfileContentState extends State<CreateProfileContent> {
  Currency currencyView = Currency.usd;

  final _controller = TextEditingController();

  final ProfileBloc profileBloc = GetIt.instance<ProfileBloc>();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is CreateProfileSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              content: Text(localization.created_profile),
            ),
          );
        } else if (state is CreateProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).colorScheme.error,
              content: const Text('Error'),
            ),
          );
        }
      },
      bloc: profileBloc,
      builder: (context, state) {
        return Center(
          child: Container(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, top: 0, bottom: 32),
              child: SingleChildScrollView(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 32, right: 32, top: 0, bottom: 64),
                    child: Text(
                      AppLocalizations.of(context)!.create_profile_description,
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 0, bottom: 32),
                      child: SizedBox(
                        child: TextField(
                          maxLength: ProfileLimits.profileNameLimitChar,
                          controller: _controller,
                          decoration: InputDecoration(
                              labelText: localization.profile_name,
                              border: const OutlineInputBorder(),
                              helperText: localization.name_profile_example,
                              suffixIcon: IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    _controller.clear();
                                  })),
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 0, bottom: 32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  SegmentedButton<Currency>(
                                    segments: const <ButtonSegment<Currency>>[
                                      ButtonSegment<Currency>(
                                          value: Currency.usd,
                                          label: Text('USD')),
                                      ButtonSegment<Currency>(
                                          value: Currency.rub,
                                          label: Text('RUB')),
                                      ButtonSegment<Currency>(
                                          value: Currency.eur,
                                          label: Text('EUR')),
                                    ],
                                    selected: <Currency>{currencyView},
                                    onSelectionChanged:
                                        (Set<Currency> newSelection) {
                                      currencyView = newSelection.first;
                                      setState(() {
                                        currencyView = newSelection.first;
                                      });
                                    },
                                  ),
                                ],
                              )),
                          Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text("In development"),
                                          ),
                                        );
                                      },
                                      child: Text(localization.more))
                                ],
                              ))
                        ],
                      )),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 0, bottom: 32),
                      child: TextButton(
                          onPressed: () => {
                                profileBloc.add(CreateProfileEvent(
                                    _controller.text, currencyView)),
                                BlocProvider.of<ProfileListBloc>(context)
                                    .add(UpdateProfilesListEvent()),
                                Navigator.pop(
                                  context,
                                  '/login',
                                )
                              },
                          child: Text(localization.create)))
                ],
              ))),
        );
      },
    );
  }
}
