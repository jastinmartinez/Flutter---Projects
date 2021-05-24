import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recruitment_app/Models/langauges.dart';
import 'package:recruitment_app/Screens/Recruitment/recruitment_language_edit_screen.dart';
import 'package:recruitment_app/Widgets/Others/search_box.dart';
import 'package:recruitment_app/Widgets/Recruitment/recruitment_languages_detail.dart';

class RecruitmentLanguageDetailScreen extends StatefulWidget {
  @override
  _RecruitmentLanguageDetailScreenState createState() =>
      _RecruitmentLanguageDetailScreenState();
}

class _RecruitmentLanguageDetailScreenState
    extends State<RecruitmentLanguageDetailScreen> {
  Languages _language;
  int _formIndex = 0;

  void _goOtherForm(int _nextFormIndex) {
    setState(
      () {
        _formIndex = _nextFormIndex;
      },
    );
  }

  void _getLanguageToEdit(Languages language) {
    setState(
      () {
        _language = language;
      },
    );
  }

  Future<void> _filterLanguagesByDescription(
      BuildContext context, String description) async {
    Provider.of<Languages>(context, listen: false)
        .filterLanguagesByDescription(description);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SearchBox(
            onChanged: (description) =>
                _filterLanguagesByDescription(context, description),
          ),
          _formIndex != 0
              ? RecruitmentLanguagesEditScreen(
                  goOtherForm: _goOtherForm,
                  languageEditMode: new Languages(
                    id: _language.id,
                    description: _language.description,
                    state: _language.state,
                  ),
                )
              : RecruitmentLanguagesDetail(
                  languages: _getLanguageToEdit,
                  goOtherForm: _goOtherForm,
                )
        ],
      ),
      bottom: false,
    );
  }
}
