import 'package:flutter/material.dart';
import 'package:market_list_flutter/screen/check_list_screen.dart';

class SaveButton extends StatelessWidget {
  final VoidCallback action;

  const SaveButton({Key? key, required this.action}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: ElevatedButton(
        onPressed: () {
          action();

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => CheckListScreen(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          fixedSize: const Size.fromWidth(160),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          backgroundColor: Colors.green,
          foregroundColor: theme.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Icon(Icons.save),
            Text(
              'Salvar',
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
