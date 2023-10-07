import 'dart:io';

import 'package:flutter/material.dart';

class FootHomeComponent extends StatelessWidget {
  const FootHomeComponent({Key? key}) : super(key: key);

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
    return Row(children: [Text('Plathorm: ${getPlathorm()}')]);
  }
}
