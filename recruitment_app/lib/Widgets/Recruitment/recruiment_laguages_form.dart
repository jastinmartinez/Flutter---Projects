import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:recruitment_app/Helpers/Design/colors_palette.dart';
import 'package:recruitment_app/Models/langauges.dart';
import 'package:recruitment_app/Widgets/Others/exception_handler.dart';
import 'package:recruitment_app/Widgets/Recruitment/recruitment_checkbox.dart';

// ignore: must_be_immutable
class RecruitmentLaguagesForm extends StatefulWidget {
  Languages languageEditMode;
  RecruitmentLaguagesForm({
    this.languageEditMode,
  });
  @override
  _RecruitmentLaguagesFormState createState() =>
      _RecruitmentLaguagesFormState();
}

class _RecruitmentLaguagesFormState extends State<RecruitmentLaguagesForm> {
  final _formKey = GlobalKey<FormState>();
  final _idController = new TextEditingController();
  final _descriptionController = new TextEditingController();
  bool _state;

  void languageState(bool state) {
    _state = state;
  }

  Future<void> _addLanguage(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      Provider.of<Languages>(context, listen: false)
          .setDataLanguage(
        new Languages(
          id: _idController != null ? _idController.text : '',
          description: _descriptionController.text,
          state: _state,
        ),
      )
          .then(
        (_) {
          setState(
            () {
              if (widget.languageEditMode != null ||
                  _idController.text.isNotEmpty) {
                widget.languageEditMode = null;
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
      ).timeout(
        Duration(seconds: 30),
        onTimeout: () async => await ExceptionHandler.timeOutSnackBar(context),
      );
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
    if (widget.languageEditMode != null) {
      _idController.text = widget.languageEditMode.id;
      _descriptionController.text = widget.languageEditMode.description;
      _state = widget.languageEditMode.state;
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
                  return 'Digite Idioma';
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
              onCheck: languageState,
              newState: _state != null ? _state : _state = false,
            ),
            SizedBox(
              height: 20,
            ),
            FlatButton(
              color: kSecondaryColor,
              onPressed: () async => await _addLanguage(context),
              child: Text('Guardar'),
            )
          ],
        ),
      ),
    );
  }
}
