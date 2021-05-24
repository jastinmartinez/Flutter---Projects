import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          child: Text(
            '404 Not Found',
            style: TextStyle(fontSize: 50),
          ),
        ),
      ),
    );
  }
}
