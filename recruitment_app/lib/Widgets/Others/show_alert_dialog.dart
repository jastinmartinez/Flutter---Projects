import 'package:flutter/material.dart';

class ShowAlertDialog extends ChangeNotifier {
  void showAlertDialog({
    BuildContext context,
    final Function yesFunction,
    final String alertName,
    final String action,
    final String itemName,
  }) {
    Widget noButton = FlatButton(
      child: Text("No"),
      onPressed: () => Navigator.pop(context),
    );
    Widget yesButton = FlatButton(
      child: Text("Si"),
      onPressed: () {
        yesFunction();
        Navigator.pop(context);
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text(alertName),
      content: Text('Desea ' + action + ' esta ' + itemName + '?'),
      actions: [
        yesButton,
        noButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
