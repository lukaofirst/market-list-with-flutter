import 'package:flutter/material.dart';
import 'package:market_list_with_flutter/ui/screens/checklist_screen.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed(ChecklistScreen.routeName);
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
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.save,
              size: 30,
            ),
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
