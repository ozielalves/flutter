import 'package:flutter/material.dart';

class WarningDialog extends StatelessWidget {
  final String title;
  final String content;
  final String primaryButtonText;
  final Function primaryButtonAction;
  final String secondaryButtonText;
  final Function secondaryButtonAction;

  WarningDialog(
      {this.title,
      this.content,
      this.primaryButtonText,
      this.primaryButtonAction,
      this.secondaryButtonText,
      this.secondaryButtonAction});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, style: TextStyle(color: Colors.white)),
      content: Text(content, style: TextStyle(color: Colors.white38)),
      actions: <Widget>[
        TextButton(
            child: Text(secondaryButtonText,
                style: TextStyle(color: Theme.of(context).primaryColor)),
            onPressed: secondaryButtonAction),
        TextButton(
          child: Text(primaryButtonText,
              style: TextStyle(color: Theme.of(context).primaryColor)),
          onPressed: primaryButtonAction,
        )
      ],
    );
  }
}
