import 'package:flutter/material.dart';

class BoxContentComponent extends StatelessWidget {
  final EdgeInsetsGeometry paddingContent;
  final String header;
  final Widget content;
  final Icon? icon;

  const BoxContentComponent({
    super.key,
    required this.paddingContent,
    required this.header,
    required this.content,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: (icon),
                  ),
                  Expanded(
                      child: Text(
                    header,
                    style: textTheme.titleLarge,
                  ))
                ],
              )),
          Padding(
              padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
              child: Row(
                children: [
                  Expanded(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                              color: colorScheme.onInverseSurface,
                              child: Padding(
                                  padding: paddingContent, child: content))))
                ],
              ))
        ],
      ),
    );
  }
}
