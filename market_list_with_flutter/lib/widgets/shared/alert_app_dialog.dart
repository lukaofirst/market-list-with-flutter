// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class AlertAppDialog extends StatelessWidget {
  final String message;
  final VoidCallback action;

  const AlertAppDialog({
    required this.message,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(message),
      actions: [
        TextButton(
          onPressed: action,
          child: const Text('Sim'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Não'),
        )
      ],
    );
  }
}
