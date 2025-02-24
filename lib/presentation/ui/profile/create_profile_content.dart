import 'package:fin_control/config.dart';
import 'package:fin_control/data/models/currency.dart';
import 'package:fin_control/presentation/utils/sysmsg.dart';
import 'package:fin_control/domain/bloc/profile/profile_bloc.dart';
import 'package:fin_control/domain/bloc/profile/profile_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateProfileContent extends StatefulWidget {
  const CreateProfileContent({Key? key}) : super(key: key);

  @override
  State<CreateProfileContent> createState() => _CreateProfileContentState();
}

class _CreateProfileContentState extends State<CreateProfileContent> {
  Currency currencyView = Currency.usd;

  final TextEditingController _controller = TextEditingController();

  late ProfileBloc _profileBloc;
  final bool clearText = false;

  @override
  void initState() {
    _profileBloc = BlocProvider.of<ProfileBloc>(context);

    _controller.addListener(() {
      final String text = _controller.text;
      _controller.value = _controller.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is CreateProfileSuccess) {
          BlocProvider.of<ProfileBloc>(context).add(UpdateProfilesListEvent());
          Navigator.pop(
            context,
            '/login',
          );

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: colorScheme.primary,
              content: Text(localization.created_profile),
            ),
          );
        } else if (state is CreateProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: colorScheme.error,
              content: () {
                switch (state.message) {
                  case ProfileNameMsg.emptyProfileName:
                    return Text(localization.emptyProfileName);
                  case ProfileNameMsg.longProfileName:
                    return Text(localization.longProfileName);
                  case ProfileNameMsg.shortProfileName:
                    return Text(localization.shortProfileName);
                  case ProfileNameMsg.errorCreateProfile:
                    return Text(localization.errorCreateProfile);
                  default:
                    return Text(localization.error);
                }
              }(),
            ),
          );
        }
      },
      bloc: _profileBloc,
      builder: (context, state) {
        return Center(
          child: Container(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.create_profile_description,
                    style: textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 32),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      maxLength: ProfileLimits.maxNameLimitChar,
                      controller: _controller,
                      decoration: InputDecoration(
                        labelText: localization.profile_name,
                        border: const OutlineInputBorder(),
                        helperText: localization.name_profile_example,
                        suffixIcon: (_controller.text.isNotEmpty)
                            ? Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    setState(() {
                                      _controller.clear();
                                    });
                                  },
                                ),
                              )
                            : null,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 32),
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
                                      value: Currency.usd, label: Text('USD')),
                                  ButtonSegment<Currency>(
                                      value: Currency.rub, label: Text('RUB')),
                                  ButtonSegment<Currency>(
                                      value: Currency.eur, label: Text('EUR')),
                                ],
                                selected: <Currency>{currencyView},
                                style: ButtonStyle(
                                  iconSize: MaterialStateProperty.all(16.0),
                                ),
                                onSelectionChanged:
                                    (Set<Currency> newSelection) {
                                  currencyView = newSelection.first;
                                  setState(() {
                                    currencyView = newSelection.first;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    showCloseIcon: true,
                                    content: Text(localization.in_development)),
                              );
                            },
                            child: Text(localization.more))
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 32, bottom: 32),
                      child: TextButton(
                          onPressed: () {
                            _profileBloc.add(CreateProfileEvent(
                                _controller.text, currencyView));

                            _profileBloc.add(UpdateProfilesListEvent());
                          },
                          child: Text(localization.create)))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
