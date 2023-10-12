import 'package:fin_control/config.dart';
import 'package:fin_control/domain/bloc/profile/profile_bloc.dart';
import 'package:fin_control/domain/bloc/profile/profile_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CreateProfileContent extends StatelessWidget {
  final profileBloc = GetIt.instance<ProfileBloc>();

  CreateProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();

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
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text("Создайте новый профиль",
                  style: Theme.of(context).textTheme.headlineSmall),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                    labelText: 'Название профиля',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _controller.clear();
                        }),
                    helperText:
                        'Осталось ${ProfileLimits.profileNameLimitChar} символ(а|ов)'),
              ),
              OutlinedButton(
                  onPressed: () => {
                        profileBloc.add(CreateProfileEvent(_controller.text)),
                        //Navigator.pushReplacementNamed(context, '/home')
                      },
                  child: const Text("Создать")),
              OutlinedButton(
                  onPressed: () => {
                        //profileBloc.add(CreateProfileEvent("New profile")),
                        Navigator.pushReplacementNamed(context, '/home')
                      },
                  child: const Text("Далее"))
            ],
          ),
        );
      },
    );
  }
}
