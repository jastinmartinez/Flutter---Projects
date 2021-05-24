import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recruitment_app/Screens/Recruitment/recruitment_competition_edit_screen.dart';
import 'package:recruitment_app/Models/competitions.dart';
import 'package:recruitment_app/Widgets/Others/search_box.dart';
import 'package:recruitment_app/Widgets/Recruitment/recruitment_competitions_detail.dart';

class RecruitmentCompetitionDetailScreen extends StatefulWidget {
  @override
  _RecruitmentCompetitionDetailScreenState createState() =>
      _RecruitmentCompetitionDetailScreenState();
}

class _RecruitmentCompetitionDetailScreenState
    extends State<RecruitmentCompetitionDetailScreen> {
  Competitions _competitions;
  int _formIndex = 0;

  void _goOtherForm(int _nextFormIndex) {
    setState(
      () {
        _formIndex = _nextFormIndex;
      },
    );
  }

  void _getEditCompetition(Competitions competitions) {
    setState(
      () {
        _competitions = competitions;
      },
    );
  }

  Future<void> _filterCompetitionByDescription(
      BuildContext context, String description) async {
    Provider.of<Competitions>(context, listen: false)
        .filterCompetitionByDescription(description);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SearchBox(
            onChanged: (description) =>
                _filterCompetitionByDescription(context, description),
          ),
          _formIndex != 0
              ? RecruitmentCompetitionEditScreen(
                  goOtherForm: _goOtherForm,
                  editModeCompetitions: new Competitions(
                    id: _competitions.id,
                    description: _competitions.description,
                    state: _competitions.state,
                  ),
                )
              : CompetitionDetail(
                  competitions: _getEditCompetition,
                  goOtherForm: _goOtherForm,
                )
        ],
      ),
      bottom: false,
    );
  }
}
