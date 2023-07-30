import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  final VoidCallback action;

  const DeleteButton({Key? key, required this.action}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: ElevatedButton(
        onPressed: action,
        style: ElevatedButton.styleFrom(
          fixedSize: const Size.fromWidth(160),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          backgroundColor: Colors.red,
          foregroundColor: theme.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Icon(Icons.delete),
            Text(
              'Apagar',
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
