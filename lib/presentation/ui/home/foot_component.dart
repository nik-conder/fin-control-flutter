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
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Text('Created by ${getPlathorm()}'));
  }
}
