// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CloseAppDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Sair do aplicativo?'),
      actions: [
        TextButton(
          onPressed: () {
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          },
          child: const Text('Sim'),
        )
      ],
    );
  }
}
