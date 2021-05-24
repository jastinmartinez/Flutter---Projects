import 'package:flutter/material.dart';
import 'package:recruitment_app/Helpers/Design/colors_palette.dart';

class IsLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Container(
          child: CircularProgressIndicator(
            backgroundColor: kSecondaryColor,
          ),
        ),
      ),
    );
  }
}
