import 'package:flutter/material.dart';

class SettingSwitch extends StatelessWidget {
  final bool state;
  final String title;
  final String? description;
  final bool? isEnabled;
  final Function(bool) onClick;

  SettingSwitch(
      {required this.state,
      required this.title,
      this.description,
      this.isEnabled,
      required this.onClick});

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  static const paddingAll = EdgeInsets.all(8);

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.green,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Выравниваем по левому краю
            children: [
              Padding(
                padding: paddingAll,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                      softWrap: true,
                    )
                  ],
                ),
              ),
              if (description != null)
                Padding(
                  padding: paddingAll,
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        // Устанавливаем ограничение на ширину
                        child: Text(
                          description!,
                          style: Theme.of(context).textTheme.bodyMedium,
                          softWrap: true, // Разрешаем перенос текста
                        ),
                      )
                    ],
                  ),
                )
            ],
          ),
          Column(
            children: [
              Padding(
                padding: paddingAll,
                child: Switch(
                  value: state,
                  onChanged: onClick,
                  thumbIcon: thumbIcon,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
