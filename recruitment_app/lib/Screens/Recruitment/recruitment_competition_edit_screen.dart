import 'package:flutter/material.dart';
import 'package:recruitment_app/Helpers/Design/colors_palette.dart';
import 'package:recruitment_app/Models/competitions.dart';

import 'package:recruitment_app/Widgets/Recruitment/recruitment_competition_form.dart';

class RecruitmentCompetitionEditScreen extends StatelessWidget {
  final Function(int index) goOtherForm;
  final Competitions editModeCompetitions;
  RecruitmentCompetitionEditScreen({
    this.goOtherForm,
    this.editModeCompetitions,
  });
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
          RecruitmentCompetitionForm(
            competitionEditMode: editModeCompetitions,
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
