import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:recruitment_app/Helpers/Design/colors_palette.dart';
import 'package:recruitment_app/Models/competitions.dart';
import 'package:recruitment_app/Widgets/common/common_dropdown.dart';

class JobRequestForm2 extends StatefulWidget {
  final Function(int index) goOtherForm;
  final GlobalKey<FormState> secondFormKey;
  final TextEditingController salaryController;
  final TextEditingController departamentController;
  final TextEditingController posititionController;
  final TextEditingController competitionController;
  final TextEditingController capacitationController;
  JobRequestForm2({
    this.departamentController,
    this.goOtherForm,
    this.salaryController,
    this.secondFormKey,
    this.capacitationController,
    this.competitionController,
    this.posititionController,
  });
  @override
  _JobRequestForm2State createState() => _JobRequestForm2State();
}

class _JobRequestForm2State extends State<JobRequestForm2> {
  Future fetchCompetitions(BuildContext context) async {
    await Provider.of<Competitions>(context, listen: false).fetchCompetitions();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.secondFormKey,
      child: ListView(
        padding: EdgeInsets.all(10),
        children: [
          ListTile(
            title: Text(
              'Detalles',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            subtitle: Text('Obligatorio'),
            leading: Text('2/3'),
            trailing: Wrap(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_left,
                    color: kBlueColor,
                    size: 50,
                  ),
                  onPressed: () => widget.goOtherForm(0),
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_right,
                    color: kBlueColor,
                    size: 50,
                  ),
                  onPressed: () {
                    bool formValidation =
                        widget.secondFormKey.currentState.validate();
                    if (formValidation) {
                      widget.goOtherForm(2);
                    } else {
                      return;
                    }
                  },
                ),
              ],
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 2,
            ),
          ),
          TextFormField(
            key: ValueKey('Salary'),
            decoration: InputDecoration(
              labelText: 'Salario',
              icon: Icon(
                Icons.payment,
                color: Colors.green,
              ),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(7),
            ],
            controller: widget.salaryController,
            validator: (salary) {
              if (salary.isEmpty) {
                return 'Digite Salario';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          Text(
            'Puesto',
            style: TextStyle(color: Colors.grey[700], fontSize: 16),
          ),
          FutureBuilder(
            future: fetchCompetitions(context),
            builder: (context, competitionsSnapshot) {
              if (competitionsSnapshot.connectionState ==
                  ConnectionState.waiting)
                return Center(child: CircularProgressIndicator());
              else
                return Consumer<Competitions>(
                  builder: (_, competitionValue, __) {
                    return new CommonDropDown([
                      if (competitionValue.getCompetitions.isNotEmpty)
                        ...competitionValue.getCompetitions
                            .where((e) => e.state)
                            .map((e) => e.description)
                      else
                        ''
                    ], widget.posititionController);
                  },
                );
            },
          ),
          TextFormField(
            key: ValueKey('Departament'),
            decoration: InputDecoration(
              labelText: 'Departamento',
              icon: Icon(
                Icons.place_rounded,
                color: kSecondaryColor,
              ),
            ),
            inputFormatters: [
              LengthLimitingTextInputFormatter(35),
            ],
            controller: widget.departamentController,
          ),
          SizedBox(height: 30),
          Text(
            'Competencias',
            style: TextStyle(color: Colors.grey[700], fontSize: 16),
          ),
          new CommonDropDown(
            [
              'Organizaciones',
              'Tecnicas',
              'Operativas',
            ],
            widget.competitionController,
          ),
          SizedBox(height: 30),
          Text(
            'Capacitaciones',
            style: TextStyle(color: Colors.grey[700], fontSize: 16),
          ),
          new CommonDropDown(
            ['Bachiretato', 'Tecnico', 'Grado', 'Post-Grado'],
            widget.capacitationController,
          ),
        ],
      ),
    );
  }
}
