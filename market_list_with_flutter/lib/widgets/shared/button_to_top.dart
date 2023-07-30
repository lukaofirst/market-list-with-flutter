// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class ButtonToTop extends StatelessWidget {
  final bool showBtn;
  final ScrollController scrollController;

  const ButtonToTop({
    required this.showBtn,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 1000),
      opacity: showBtn ? 1.0 : 0.0,
      child: FloatingActionButton(
        onPressed: () {
          scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn,
          );
        },
        backgroundColor: Colors.amber,
        child: const Icon(Icons.arrow_upward),
      ),
    );
  }
}
