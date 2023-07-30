// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final String message;

  const Loading({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              semanticsLabel: message,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(message),
          )
        ],
      ),
    );
  }
}
