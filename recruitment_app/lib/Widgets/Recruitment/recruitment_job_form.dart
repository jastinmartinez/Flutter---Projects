import 'package:enum_to_string/enum_to_string.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:recruitment_app/Helpers/Design/colors_palette.dart';
import 'package:recruitment_app/Helpers/Others/validation.dart';
import 'package:recruitment_app/Models/audit.dart';

import 'package:recruitment_app/Models/jobs.dart';
import 'package:recruitment_app/Widgets/Others/screen_messages.dart';

import 'package:recruitment_app/Widgets/common/common_dropdown.dart';

class RecruitmentJobForm extends StatefulWidget {
  @override
  _RecruitmentJobFormState createState() => _RecruitmentJobFormState();
}

class _RecruitmentJobFormState extends State<RecruitmentJobForm> {
  final _formKey = new GlobalKey<FormState>();
  final _titleController = new TextEditingController();
  final _descriptionController = new TextEditingController();
  final _amountPositionController = new TextEditingController();
  final _minSalaryController = new TextEditingController();
  final _maxSalaryController = new TextEditingController();
  final _riskController = new TextEditingController();
  final _stateController = new TextEditingController();

  Future<void> addJob(BuildContext context) async {
    if (_formKey.currentState.validate())
      await Provider.of<Jobs>(context, listen: false)
          .addJob(
        new Jobs(
          title: _titleController.text,
          description: _descriptionController.text,
          amountOfPositions: int.parse(_amountPositionController.text),
          minSalary: int.parse(_minSalaryController.text),
          maxSalary: int.parse(_maxSalaryController.text),
          jobRisk:
              EnumToString.fromString(JobRisk.values, _riskController.text),
          jobState:
              EnumToString.fromString(JobState.values, _stateController.text),
          audit: Audit.createdAudit,
        ),
      )
          .whenComplete(
        () {
          _titleController.clear();
          _titleController.clear();
          _descriptionController.clear();
          _amountPositionController.clear();
          _minSalaryController.clear();
          _maxSalaryController.clear();
          _riskController.clear();
          _stateController.clear();
        },
      );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _amountPositionController.dispose();
    _minSalaryController.dispose();
    _maxSalaryController.dispose();
    _riskController.dispose();
    _stateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenMessage = new ScreenMessages(context, 'Guardando Informacion');
    return Container(
      decoration: BoxDecoration(
        color: kBackgroundColor,
      ),
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Titulo'),
              controller: _titleController,
              inputFormatters: [
                LengthLimitingTextInputFormatter(35),
              ],
              validator: (value) => value.isEmpty ? 'Digitar Titulo' : null,
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Descripcion',
              ),
              keyboardType: TextInputType.multiline,
              maxLines: 2,
              inputFormatters: [
                LengthLimitingTextInputFormatter(300),
              ],
              validator: (value) =>
                  value.isEmpty ? 'Digitar Description' : null,
            ),
            TextFormField(
              controller: _amountPositionController,
              decoration: InputDecoration(labelText: 'Cantidad de Vacantes'),
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(2),
                FilteringTextInputFormatter.digitsOnly,
              ],
              validator: (value) =>
                  Validation.number(value, text: 'Salario Maximo'),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Estatus',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            SizedBox(
              height: 5,
            ),
            CommonDropDown([
              ...EnumToString.toList<JobRisk>(JobRisk.values),
            ], _riskController),
            TextFormField(
              controller: _minSalaryController,
              decoration: InputDecoration(labelText: 'Salario Minimo'),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(6)
              ],
              validator: (value) =>
                  Validation.number(value, text: 'Salario Minimo'),
            ),
            TextFormField(
              controller: _maxSalaryController,
              decoration: InputDecoration(labelText: 'Salario Maximo'),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(6)
              ],
              validator: (value) =>
                  Validation.number(value, text: 'Salario Maximo'),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Estatus',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            SizedBox(
              height: 5,
            ),
            CommonDropDown([
              ...EnumToString.toList<JobState>(JobState.values),
            ], _stateController),
            SizedBox(
              height: 30,
            ),
            FlatButton(
              onPressed: () async {
                await screenMessage.progressLoadingProcess.show();
                await addJob(context);
                await screenMessage.progressLoadingProcess.hide();
              },
              child: Text('Guardar'),
              color: kSecondaryColor,
            )
          ],
        ),
      ),
    );
  }
}
