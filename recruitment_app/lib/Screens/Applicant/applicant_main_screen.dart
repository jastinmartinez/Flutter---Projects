import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recruitment_app/Models/auth.dart';
import 'package:recruitment_app/Screens/Jobs/jobs_requested_screen.dart';
import 'package:recruitment_app/Screens/Jobs/jobs_screen.dart';

import 'package:recruitment_app/helpers/design/colors_palette.dart';

class ApplicantMainScreen extends StatefulWidget {
  const ApplicantMainScreen({Key key}) : super(key: key);
  @override
  _ApplicantMainScreenState createState() => _ApplicantMainScreenState();
}

class _ApplicantMainScreenState extends State<ApplicantMainScreen> {
  String _jobWidgetTitle = 'Vacantes';
  int jobSelectedWidgetIndex = 0;
  static List<Widget> _jobWidgets = <Widget>[
    JobsScreen(),
    JobsRequestedScreen(),
  ];

  void _onItemTapped(int index) {
    setState(
      () {
        jobSelectedWidgetIndex = index;
        switch (jobSelectedWidgetIndex) {
          case 0:
            {
              _jobWidgetTitle = 'Vacantes';
            }
            break;
          case 1:
            {
              _jobWidgetTitle = 'Enviadas';
            }
            break;
          default:
            break;
        }
      },
    );
  }

  Future<void> authSignOut(BuildContext context) async {
    await Provider.of<Auth>(context, listen: false).authSignOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_jobWidgetTitle),
        elevation: 0,
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async => await authSignOut(context),
          ),
        ],
      ),
      backgroundColor: kPrimaryColor,
      body: _jobWidgets.elementAt(jobSelectedWidgetIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            // ignore: deprecated_member_use
            title: Text('Vacantes'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.send),
            // ignore: deprecated_member_use
            title: Text('Enviadas'),
          )
        ],
        currentIndex: jobSelectedWidgetIndex,
        selectedItemColor: kPrimaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
