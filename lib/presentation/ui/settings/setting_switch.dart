import 'package:flutter/material.dart';

class SettingSwitch extends StatelessWidget {
  final bool state;
  final String title;
  final String? description;
  final bool? isEnabled;
  final Function(bool) onClick;

  static const paddingAll = EdgeInsets.all(8);

  SettingSwitch(
      {super.key,
      required this.state,
      required this.title,
      this.description,
      this.isEnabled,
      required this.onClick});

  final WidgetStateProperty<Icon?> thumbIcon =
      WidgetStateProperty.resolveWith<Icon?>(
    (Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: paddingAll,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textTheme.titleSmall,
                softWrap: true,
              ),
              if (description != null)
                Text(
                  (description != null) ? description! : '',
                  style: textTheme.bodySmall,
                  softWrap: true,
                ),
            ],
          )),
          Column(
            children: [
              Switch(
                value: state,
                onChanged: onClick,
                thumbIcon: thumbIcon,
              ),
            ],
          )
        ],
      ),
    );
  }
}
