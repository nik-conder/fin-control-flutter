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
    return Padding(
      padding: paddingAll,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(
                        left: 4,
                        top: 4,
                      ),
                      child: Flexible(
                        child: Text(
                          title,
                          style: Theme.of(context).textTheme.titleSmall,
                          softWrap: true,
                        ),
                      )),
                ],
              ),
              if (description != null)
                Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(
                          left: 4,
                          top: 4,
                        ),
                        child: Flexible(
                          child: Text(
                            // FIXME: text not wrapped
                            (description != null) ? description! : '',
                            style: Theme.of(context).textTheme.bodySmall,
                            softWrap: true,
                          ),
                        )),
                  ],
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
    );
  }
}
