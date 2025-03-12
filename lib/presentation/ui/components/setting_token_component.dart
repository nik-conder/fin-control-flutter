import 'package:fin_control/presentation/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/bloc/token/token_bloc.dart';

class SettingTokenComponent extends StatefulWidget {
  const SettingTokenComponent({super.key});

  @override
  State<SettingTokenComponent> createState() => _SettingTokenComponentState();
}

class _SettingTokenComponentState extends State<SettingTokenComponent> {
  String? _token = null;
  final TextEditingController _controller = TextEditingController();

  void initState() {
    super.initState();
    context.read<TokenBloc>().add(GetToken());
  }

  _setToken(String value) {
    setState(() {
      _token = value;
    });
  }

  // _setTokenValueController(String value) {
  //   setState(() {
  //     _controller.text = value;
  //     _token = value;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Текущий токен:',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    BlocBuilder<TokenBloc, TokenState>(
                      builder: (context, state) {
                        if (state is GetTokenSuccess) {
                          return Row(
                            spacing: 8,
                            children: [
                              (_token != null)
                                  ? Text(
                                      Utils.hidePartOfToken(_token!),
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    )
                                  : const CircularProgressIndicator(),
                              const Icon(Icons.check_circle_outline_outlined,
                                  color: Colors.green),
                            ],
                          );
                        } else if (state is GetTokenError) {
                          return const Row(
                            spacing: 8,
                            children: [
                              Text('не найден'),
                              Icon(Icons.cancel_outlined, color: Colors.red),
                            ],
                          );
                        } else if (state is GetTokenLoading) {
                          return const SizedBox(
                            child: Center(child: CircularProgressIndicator()),
                            height: 18.0,
                            width: 18.0,
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Новый токен',
                        ),
                        controller: _controller,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        BlocConsumer<TokenBloc, TokenState>(
          listener: (context, state) {
            if (state is GetTokenSuccess) {
              _setToken(state.token);
            }
          },
          builder: (context, state) {
            if (state is SetTokenSuccess) {
              return const Text('ok');
            } else if (state is SetTokenError) {
              return const Text('err');
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: TextButton(
                  onPressed: () {
                    context.read<TokenBloc>().add(DeleteToken());
                  },
                  child: const Text('Удалить'),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 8),
                child: TextButton(
                  onPressed: null,
                  child: Text('Изменить'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: TextButton(
                  onPressed: () {
                    context.read<TokenBloc>().add(SetToken(_controller.text));
                  },
                  child: const Text('Сохранить'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
