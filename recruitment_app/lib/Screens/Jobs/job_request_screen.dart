import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recruitment_app/Database/responsive_helper.dart';
import 'package:recruitment_app/Helpers/Design/colors_palette.dart';
import 'package:recruitment_app/Models/audit.dart';
import 'package:recruitment_app/Models/jobs.dart';

import 'package:recruitment_app/Models/jobs_requested.dart';

import 'package:recruitment_app/Widgets/Jobs/job_request_form.dart';
import 'package:recruitment_app/Widgets/Jobs/job_request_form_2.dart';
import 'package:recruitment_app/Widgets/Jobs/job_request_form_3.dart';

class JobRequestScreen extends StatefulWidget {
  final Jobs job;
  const JobRequestScreen({
    Key key,
    this.job,
  })  : assert(job != null),
        super(key: key);

  @override
  _JobRequestScreenState createState() => _JobRequestScreenState();
}

class _JobRequestScreenState extends State<JobRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final _secondFormKey = GlobalKey<FormState>();
  final _thirdFormKey = GlobalKey<FormState>();

  final _idController = new TextEditingController();
  final _nameController = new TextEditingController();
  final _lastNameController = new TextEditingController();
  final _addressController = new TextEditingController();
  final _phoneController = new TextEditingController();
  final _departamentController = new TextEditingController();
  final _salaryController = new TextEditingController();
  final _posititionController = new TextEditingController();
  final _competitionController = new TextEditingController();
  final _capacitationController = new TextEditingController();
  final _companyController = new TextEditingController();
  final _oldPosititionController = new TextEditingController();
  final _oldSalaryController = new TextEditingController();

  DateTime _fromDate;
  DateTime _toDate;

  int _formIndex = 0;

  void fromDate(DateTime fromDate) {
    _fromDate = fromDate;
  }

  void toDate(DateTime fromDate) {
    _toDate = fromDate;
  }

  void _goOtherForm(int _nextFormIndex) {
    setState(
      () {
        _formIndex = _nextFormIndex;
      },
    );
  }

  Future<void> _submitForm(BuildContext context) async {
    await Provider.of<JobsRequested>(context, listen: false)
        .addJobRequest(
      new JobsRequested(
        userId: _idController.text,
        name: _nameController.text,
        lastName: _lastNameController.text,
        phoneNumber: _phoneController.text,
        address: _addressController.text,
        salary: int.parse(_salaryController.text),
        position: _posititionController.text,
        departament: _departamentController.text,
        competition: _competitionController.text,
        capacitation: _capacitationController.text,
        jobsExperience: {
          'expCompany': _companyController.text,
          'expPosition': _oldPosititionController.text,
          'expSalary': _oldSalaryController.text.isNotEmpty
              ? int.parse(_oldSalaryController.text)
              : 0,
          'expFromDate': _fromDate,
          'expFromToDate': _toDate,
        },
        audit: Audit.createdAudit,
      ),
    )
        .then(
      (_) {
        _idController.clear();
        _nameController.clear();
        _lastNameController.clear();
        _addressController.clear();
        _phoneController.clear();
        _departamentController.clear();
        _salaryController.clear();
        _posititionController.clear();
        _competitionController.clear();
        _capacitationController.clear();
        _companyController.clear();
        _oldSalaryController.clear();
        _oldPosititionController.clear();
      },
    ).catchError(
      (error) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(error),
            backgroundColor: Theme.of(context).errorColor,
          ),
        );
      },
    ).timeout(
      Duration(
        seconds: 10,
      ),
      onTimeout: () async => timeOut(context),
    );
  }

  void timeOut(BuildContext context) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Sin Conexion'),
        backgroundColor: Theme.of(context).errorColor,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _idController.dispose();
    _nameController.dispose();
    _lastNameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _departamentController.dispose();
    _salaryController.dispose();
    _posititionController.dispose();
    _competitionController.dispose();
    _capacitationController.dispose();
    _companyController.dispose();
    _oldSalaryController.dispose();
    _oldPosititionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsiveHelper = ResponsiveHelper.of(context);
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    height: responsiveHelper.hp(70),
                    margin: const EdgeInsets.only(
                      top: 100,
                      left: 10.0,
                      right: 10.0,
                    ),
                    padding: const EdgeInsets.all(20.0),
                    child: _formIndex == 0
                        ? JobRequestForm(
                            formKey: _formKey,
                            goOtherForm: _goOtherForm,
                            addressController: _addressController,
                            idController: _idController,
                            lastNameController: _lastNameController,
                            nameController: _nameController,
                            phoneController: _phoneController,
                          )
                        : _formIndex == 1
                            ? JobRequestForm2(
                                departamentController: _departamentController,
                                goOtherForm: _goOtherForm,
                                salaryController: _salaryController,
                                secondFormKey: _secondFormKey,
                                capacitationController: _capacitationController,
                                competitionController: _competitionController,
                                posititionController: _posititionController,
                              )
                            : JobRequestForm3(
                                goOtherForm: _goOtherForm,
                                thirdFormKey: _thirdFormKey,
                                fromDate: fromDate,
                                toDate: toDate,
                                companyController: _companyController,
                                oldPosititionController:
                                    _oldPosititionController,
                                oldSalaryController: _oldSalaryController,
                                submit: () => _submitForm(context),
                              ),
                    decoration: BoxDecoration(
                      color: kBackgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottom: false,
      ),
    );
  }
}
