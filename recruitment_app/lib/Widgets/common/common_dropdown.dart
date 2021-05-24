import 'package:flutter/material.dart';

class CommonDropDown extends StatefulWidget {
  final List<String> list;
  final TextEditingController controller;

  CommonDropDown(
    this.list,
    this.controller,
  );
  @override
  _CommonDropDownState createState() => _CommonDropDownState();
}

class _CommonDropDownState extends State<CommonDropDown> {
  @override
  Widget build(BuildContext context) {
    if (widget.controller.text.isEmpty) {
      widget.controller.text = widget.list[0];
    }
    return DropdownButtonFormField<String>(
      value: widget.controller.text,
      items: widget.list.map<DropdownMenuItem<String>>(
        (String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        },
      ).toList(),
      onChanged: (String newValue) {
        setState(
          () {
            widget.controller.text = newValue;
          },
        );
      },
    );
  }
}
