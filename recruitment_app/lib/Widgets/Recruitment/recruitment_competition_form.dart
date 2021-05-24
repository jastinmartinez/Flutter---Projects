import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:recruitment_app/Helpers/Design/colors_palette.dart';
import 'package:recruitment_app/Models/competitions.dart';
import 'package:recruitment_app/Widgets/Others/exception_handler.dart';
import 'package:recruitment_app/Widgets/Recruitment/recruitment_checkbox.dart';

// ignore: must_be_immutable
class RecruitmentCompetitionForm extends StatefulWidget {
  Competitions competitionEditMode;
  RecruitmentCompetitionForm({
    this.competitionEditMode,
  });
  @override
  _RecruitmentCompetitionFormState createState() =>
      _RecruitmentCompetitionFormState();
}

class _RecruitmentCompetitionFormState
    extends State<RecruitmentCompetitionForm> {
  final _formKey = GlobalKey<FormState>();
  final _idController = new TextEditingController();
  final _descriptionController = new TextEditingController();
  bool _state;

  void competitionState(bool state) {
    _state = state;
  }

  Future<void> _addCompetition(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      Provider.of<Competitions>(context, listen: false)
          .setDataCompetition(
        new Competitions(
          id: _idController != null ? _idController.text : null,
          description: _descriptionController.text,
          state: _state,
        ),
      )
          .then(
        (_) {
          setState(
            () {
              if (widget.competitionEditMode != null ||
                  _idController.text.isNotEmpty) {
                widget.competitionEditMode = null;
              } else {
                _descriptionController.clear();
                _state = false;
              }
            },
          );
        },
      ).catchError(
        (onError) {
          ExceptionHandler.erroSnackBar(context, onError);
        },
      ).timeout(Duration(seconds: 30),
              onTimeout: () async =>
                  await ExceptionHandler.timeOutSnackBar(context));
    }
  }

  @override
  void dispose() {
    _idController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.competitionEditMode != null) {
      _idController.text = widget.competitionEditMode.id;
      _descriptionController.text = widget.competitionEditMode.description;
      _state = widget.competitionEditMode.state;
    }
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Descripcion'),
              validator: (desc) {
                if (desc.isEmpty) {
                  return 'Digite Competencia';
                }
                return null;
              },
              inputFormatters: [
                LengthLimitingTextInputFormatter(35),
              ],
              controller: _descriptionController,
            ),
            SizedBox(
              height: 20,
            ),
            new RecruitmentCheckbox(
              checkBoxName: 'Estado',
              onCheck: competitionState,
              newState: _state != null ? _state : _state = false,
            ),
            SizedBox(
              height: 20,
            ),
            FlatButton(
              color: kSecondaryColor,
              onPressed: () async => await _addCompetition(context),
              child: Text('Guardar'),
            )
          ],
        ),
      ),
    );
  }
}
