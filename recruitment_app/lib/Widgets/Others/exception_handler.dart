import 'package:flutter/material.dart';

class ExceptionHandler {
  static void erroSnackBar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).errorColor,
      ),
    );
  }

  static Future timeOutSnackBar(BuildContext context) async {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Sin Conexion'),
        backgroundColor: Theme.of(context).errorColor,
      ),
    );
  }
}
