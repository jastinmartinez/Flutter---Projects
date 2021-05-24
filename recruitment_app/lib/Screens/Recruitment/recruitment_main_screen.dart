import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recruitment_app/Helpers/Design/colors_palette.dart';
import 'package:recruitment_app/Models/auth.dart';
import 'package:recruitment_app/Screens/Recruitment/recruiment_job_add_screen.dart';
import 'package:recruitment_app/Screens/Recruitment/recruitment_competitions_detail_screen.dart';
import 'package:recruitment_app/Screens/Recruitment/recruitment_competition_add_screen.dart';
import 'package:recruitment_app/Screens/Recruitment/recruitment_language_add_screen.dart';
import 'package:recruitment_app/Screens/Recruitment/recruitment_language_detail_screen.dart';
import 'package:recruitment_app/Screens/Recruitment/recruitment_home_screen.dart';
import 'package:recruitment_app/Widgets/Recruitment/recruitment_drawer.dart';

class RecruitmentMainScreen extends StatefulWidget {
  @override
  _RecruitmentMainScreenState createState() => _RecruitmentMainScreenState();
}

class _RecruitmentMainScreenState extends State<RecruitmentMainScreen> {
  String _title = 'Inicio';
  int selectedIndex = 0;
  static List<Widget> _widgetsOptions = <Widget>[
    RecruitmentHomeScreen(),
    RecruitmentJobAddScreen(),
    RecruitmentCompetitionAddScreen(),
    RecruitmentCompetitionDetailScreen(),
    RecruitmentLanguageAddScreen(),
    RecruitmentLanguageDetailScreen(),
  ];

  Future<void> authSignOut(BuildContext context) async {
    await Provider.of<Auth>(context, listen: false).authSignOut();
  }

  void _onItemTapped(int index) {
    setState(
      () {
        selectedIndex = index;
        switch (selectedIndex) {
          case 0:
            {
              _title = 'Inicio';
            }
            break;
          case 1:
            {
              _title = 'Crear - Puesto';
            }
            break;
          case 2:
            {
              _title = 'Visualizar - Competencias';
            }
            break;
            break;
          default:
            break;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          _title,
          style: TextStyle(
            color: kSecondaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async => await authSignOut(context),
          ),
        ],
      ),
      drawer: RecruitmentDrawer(
        menuItemTap: _onItemTapped,
      ),
      body: _widgetsOptions.elementAt(selectedIndex),
    );
  }
}
