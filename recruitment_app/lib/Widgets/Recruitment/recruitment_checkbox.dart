import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recruitment_app/Models/competitions.dart';

// ignore: must_be_immutable
class RecruitmentCheckbox extends StatefulWidget {
  RecruitmentCheckbox({
    Key key,
    @required Function(bool) onCheck,
    @required String checkBoxName,
    @required bool newState,
  })  : _onCheck = onCheck,
        _checkBoxName = checkBoxName,
        _newState = newState,
        super(key: key);
  final Function(bool) _onCheck;
  final String _checkBoxName;
  bool _newState;

  @override
  _RecruitmentCheckboxState createState() => _RecruitmentCheckboxState();
}

class _RecruitmentCheckboxState extends State<RecruitmentCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Competitions>(
      builder: (ctx, value, child) => CheckboxListTile(
        value: widget._newState,
        title: Text(widget._checkBoxName),
        onChanged: (bool stateChange) {
          setState(
            () {
              widget._newState = stateChange;
              widget._onCheck(widget._newState);
            },
          );
        },
      ),
    );
  }
}
