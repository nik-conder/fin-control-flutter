import 'dart:io';

import 'package:flutter/material.dart';

class FootComponent extends StatelessWidget {
  const FootComponent({Key? key}) : super(key: key);

  String getPlathorm() {
    if (Platform.isAndroid) {
      return 'Android';
    } else if (Platform.isIOS) {
      return 'iOS';
    } else if (Platform.isMacOS) {
      return 'MacOS';
    } else if (Platform.isWindows) {
      return 'Windows';
    } else if (Platform.isLinux) {
      return 'Linux';
    } else {
      return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(24),
        color: Theme.of(context).colorScheme.inversePrimary,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'Created by ${getPlathorm()}',
          )
        ]));
  }
}
