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
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.95,
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
                    style: Theme.of(context).textTheme.titleMedium,
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
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                              child: Padding(
                                  padding: paddingContent, child: content))))
                ],
              ))
        ],
      ),
    );
  }
}
