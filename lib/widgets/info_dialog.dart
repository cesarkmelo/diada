import 'package:diada/utils/constants.dart';
import 'package:flutter/material.dart';

class InfoDialog extends StatelessWidget {
  final String title;
  final Widget child;

  InfoDialog({required this.title, required this.child});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: kScaffoldColor,
      title: Text(
        title,
        style: TextStyle(
            color: kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 22.0),
      ),
      content: child,
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        TextButton(
          child: const Text("Cerrar", style: TextStyle(color: kPrimaryColor)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
