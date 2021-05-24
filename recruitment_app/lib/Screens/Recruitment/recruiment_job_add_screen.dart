import 'package:flutter/material.dart';
import 'package:recruitment_app/Helpers/Design/colors_palette.dart';
import 'package:recruitment_app/Widgets/Recruitment/recruitment_job_form.dart';

class RecruitmentJobAddScreen extends StatefulWidget {
  @override
  _RecruitmentJobAddScreenState createState() =>
      _RecruitmentJobAddScreenState();
}

class _RecruitmentJobAddScreenState extends State<RecruitmentJobAddScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: kBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: RecruitmentJobForm(),
            ),
          ),
        ],
      ),
      bottom: false,
    );
  }
}
