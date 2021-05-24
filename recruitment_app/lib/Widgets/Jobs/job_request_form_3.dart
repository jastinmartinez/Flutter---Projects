import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recruitment_app/Helpers/Design/colors_palette.dart';
import 'package:intl/intl.dart';
import 'package:recruitment_app/Widgets/Others/screen_messages.dart';

class JobRequestForm3 extends StatefulWidget {
  final Function(int index) goOtherForm;

  final GlobalKey<FormState> thirdFormKey;
  final TextEditingController companyController;
  final TextEditingController oldPosititionController;
  final TextEditingController oldSalaryController;
  final Function submit;
  final Function(DateTime toDate) fromDate;
  final Function(DateTime toDate) toDate;
  JobRequestForm3({
    this.thirdFormKey,
    this.goOtherForm,
    this.companyController,
    this.oldPosititionController,
    this.oldSalaryController,
    this.fromDate,
    this.toDate,
    this.submit,
  });

  @override
  _JobRequestForm3State createState() => _JobRequestForm3State();
}

class _JobRequestForm3State extends State<JobRequestForm3> {
  DateTime _fromDate = new DateTime.now();
  DateTime _toDate = new DateTime.now();
  Future<Null> _selectDate(
      BuildContext context, DateTime date, int index) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != date) {
      setState(
        () {
          date = picked;
          switch (index) {
            case 0:
              widget.fromDate(date);
              _fromDate = date;
              break;
            case 1:
              widget.toDate(date);
              _toDate = date;
              break;
            default:
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ph = new ScreenMessages(context, 'Guardando Informacion');
    return Form(
      key: widget.thirdFormKey,
      child: ListView(
        padding: EdgeInsets.all(10),
        children: [
          ListTile(
            title: Text(
              'Experiencial Laboral',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            leading: Text('3/3'),
            subtitle: Text('Opcional'),
            trailing: IconButton(
              icon: Icon(
                Icons.arrow_left,
                color: kBlueColor,
                size: 50,
              ),
              onPressed: () => widget.goOtherForm(1),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 2,
            ),
          ),
          TextFormField(
            key: ValueKey('Company'),
            decoration: InputDecoration(
              labelText: 'Empresa',
              icon: Icon(
                Icons.business,
                color: kBlueColor,
              ),
            ),
            inputFormatters: [
              LengthLimitingTextInputFormatter(35),
            ],
            controller: widget.companyController,
          ),
          TextFormField(
            key: ValueKey('Position-exp'),
            decoration: InputDecoration(
              labelText: 'Puesto',
              icon: Icon(
                Icons.contact_page,
                color: kSecondaryColor,
              ),
            ),
            inputFormatters: [
              LengthLimitingTextInputFormatter(35),
            ],
            controller: widget.oldPosititionController,
          ),
          TextFormField(
            key: ValueKey('Salary-exp'),
            decoration: InputDecoration(
              labelText: 'Salario',
              icon: Icon(
                Icons.payment,
                color: Colors.green,
              ),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(7),
            ],
            controller: widget.oldSalaryController,
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            title: Text('Fecha de inicio'),
            subtitle: Text(
              DateFormat('dd/MM/yyyy').format(_fromDate),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 2,
            ),
            trailing: FlatButton(
              color: kBlueColor,
              child: Text('Elegir Fecha'),
              onPressed: () => _selectDate(context, _fromDate, 0),
            ),
          ),
          ListTile(
            title: Text('Fecha de salida'),
            subtitle: Text(
              DateFormat('dd/MM/yyyy').format(_toDate),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 2,
            ),
            trailing: FlatButton(
              color: kBlueColor,
              child: Text('Elegir Fecha'),
              onPressed: () => _selectDate(context, _toDate, 1),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 70,
              right: 70,
            ),
            child: FlatButton(
              color: kSecondaryColor,
              onPressed: () async {
                await ph.progressLoadingProcess.show();
                await widget.submit();
                await ph.progressLoadingProcess.hide();
                widget.goOtherForm(0);
              },
              child: Text('Enviar'),
            ),
          ),
        ],
      ),
    );
  }
}
