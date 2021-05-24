import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:recruitment_app/Models/jobs.dart';
import 'package:recruitment_app/Models/langauges.dart';

import 'package:recruitment_app/Models/user.dart';

import 'package:recruitment_app/Screens/main_screen.dart';

import 'package:recruitment_app/Models/auth.dart';
import 'package:recruitment_app/Models/competitions.dart';

import 'package:recruitment_app/Models/jobs_requested.dart';
import 'package:recruitment_app/Screens/Auth/auth_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:recruitment_app/Widgets/Others/isloading.dart';
import 'package:recruitment_app/Widgets/Others/show_alert_dialog.dart';
import 'Helpers/Design/colors_palette.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await localDatabase();
  runApp(MyApp());
}

Future localDatabase() async {
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox('user');
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    Hive.box('user').close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (context) => Jobs(),
        ),
        ChangeNotifierProvider(
          create: (context) => Competitions(),
        ),
        ChangeNotifierProvider(
          create: (context) => JobsRequested(),
        ),
        ChangeNotifierProvider(
          create: (context) => ShowAlertDialog(),
        ),
        ChangeNotifierProvider(
          create: (context) => User(),
        ),
        ChangeNotifierProvider(
          create: (context) => Languages(),
        ),
        ChangeNotifierProvider(
          create: (context) => Jobs(),
        )
      ],
      child: MaterialApp(
        title: 'Recruiter App',
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
          primaryColor: kPrimaryColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  Future fetchUser(BuildContext context) async {
    await Provider.of<User>(context, listen: false).fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, authSnapshot) {
        if (authSnapshot.connectionState == ConnectionState.waiting) {
          return IsLoading();
        }
        if (authSnapshot.hasData) {
          return MainScreen();
        }
        return AuthScreen();
      },
    );
  }
}
