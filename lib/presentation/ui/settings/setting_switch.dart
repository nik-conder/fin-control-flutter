import 'package:flutter/material.dart';

class SettingSwitch extends StatelessWidget {
  final bool state;
  final String title;
  final String? description;
  final bool? isEnabled;
  final Function(bool) onClick;

  SettingSwitch(
      {super.key,
      required this.state,
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
    return Expanded(
        child: Padding(
      padding: paddingAll,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 8,
                  top: 8,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
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
                  padding: const EdgeInsets.only(
                    left: 8,
                    top: 8,
                  ),
                  child: Row(
                    children: [
                      Text(
                        // FIXME: text not wrapped
                        (description != null) ? description! : '',
                        style: Theme.of(context).textTheme.bodyMedium,
                        softWrap: true,
                      )
                    ],
                  ),
                ),
            ],
          ),
          Column(children: [
            Switch(
              value: state,
              onChanged: onClick,
              thumbIcon: thumbIcon,
            ),
          ])
        ],
      ),
    ));
  }
}

/*
Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
              softWrap: true,
            )
          ],
        ),
        Row(
          children: [
            if (description != null)
              Text(
                description!,
                style: Theme.of(context).textTheme.bodyMedium,
                softWrap: true,
              )
          ],
        )
      ]),
      Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Switch(
          value: state,
          onChanged: onClick,
          thumbIcon: thumbIcon,
        ),
      ])
    ]));
*/