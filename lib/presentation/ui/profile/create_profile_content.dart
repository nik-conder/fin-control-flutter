import 'package:fin_control/config.dart';
import 'package:fin_control/data/models/currency.dart';
import 'package:fin_control/domain/bloc/profile/profile_bloc.dart';
import 'package:fin_control/domain/bloc/profile/profile_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateProfileContent extends StatelessWidget {
  CreateProfileContent({super.key});

  final profileBloc = GetIt.instance<ProfileBloc>();
  final padding = const EdgeInsets.all(8);
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is CreateProfileSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: const Text('Success'),
              action: SnackBarAction(
                label: 'Action',
                onPressed: () {
                  // Code to execute.
                },
              ),
            ),
          );
        } else if (state is CreateProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: const Text('Error'),
              action: SnackBarAction(
                label: 'Action',
                onPressed: () {
                  // Code to execute.
                },
              ),
            ),
          );
        }
      },
      bloc: profileBloc,
      builder: (context, state) {
        return Container(
          padding: padding,
          child: Column(
            children: [
              Padding(
                padding: padding,
                child: Text(AppLocalizations.of(context)!.create_new_profile,
                    style: Theme.of(context).textTheme.headlineSmall),
              ),
              Padding(
                padding: padding,
                child: TextField(
                  maxLength: ProfileLimits.profileNameLimitChar,
                  controller: _controller,
                  decoration: InputDecoration(
                      labelText: 'Название профиля',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _controller.clear();
                          })),
                ),
              ),
              Padding(padding: padding, child: const ChangeCurrencyComponent()),
              Padding(
                  padding: padding,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: padding,
                              child: OutlinedButton(
                                  onPressed: () => {
                                        profileBloc.add(CreateProfileEvent(
                                            _controller.text)),

                                        //Navigator.pushReplacementNamed(context, '/home')
                                      },
                                  child: const Text("Создать")),
                            ),
                          ],
                        )
                      ]))
            ],
          ),
        );
      },
    );
  }
}

class ChangeCurrencyComponent extends StatefulWidget {
  const ChangeCurrencyComponent({super.key});

  @override
  State<ChangeCurrencyComponent> createState() =>
      _ChangeCurrencyComponentState();
}

class _ChangeCurrencyComponentState extends State<ChangeCurrencyComponent> {
  Currency currencyView = Currency.usd;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Currency>(
      segments: const <ButtonSegment<Currency>>[
        ButtonSegment<Currency>(value: Currency.usd, label: Text('USD')),
        ButtonSegment<Currency>(value: Currency.rub, label: Text('RUB')),
        ButtonSegment<Currency>(value: Currency.eur, label: Text('EUR')),
      ],
      selected: <Currency>{currencyView},
      onSelectionChanged: (Set<Currency> newSelection) {
        currencyView = newSelection.first;
        setState(() {
          // By default there is only a single segment that can be
          // selected at one time, so its value is always the first
          // item in the selected set.
          currencyView = newSelection.first;
        });
      },
    );
  }
}
