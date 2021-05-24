import 'package:flutter/material.dart';
import 'package:recruitment_app/Helpers/Design/colors_palette.dart';
import 'package:recruitment_app/Models/langauges.dart';
import 'package:recruitment_app/Widgets/Recruitment/recruiment_laguages_form.dart';

class RecruitmentLanguagesEditScreen extends StatelessWidget {
  final Function(int index) goOtherForm;
  final Languages languageEditMode;
  RecruitmentLanguagesEditScreen({this.goOtherForm, this.languageEditMode});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          ListTile(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: kBlueColor,
              ),
              onPressed: () => goOtherForm(0),
            ),
            title: Text(
              'Editando',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w100,
              ),
            ),
          ),
          RecruitmentLaguagesForm(
            languageEditMode: languageEditMode,
          ),
        ],
      ),
      margin: EdgeInsets.only(
        top: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(40),
        ),
      ),
    );
  }
}
