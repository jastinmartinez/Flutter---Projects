import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recruitment_app/Models/user.dart';
import 'package:recruitment_app/Screens/Applicant/applicant_main_screen.dart';
import 'package:recruitment_app/Screens/Recruitment/recruitment_main_screen.dart';
import 'package:recruitment_app/Widgets/Others/isloading.dart';
import 'package:recruitment_app/Widgets/Others/not_found.dart';

class MainScreen extends StatelessWidget {
  Future<void> fetchLocalUser(BuildContext context) async {
    await Provider.of<User>(context, listen: false).fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchLocalUser(context),
      builder: (context, userSnapshot) =>
          userSnapshot.connectionState == ConnectionState.waiting
              ? IsLoading()
              : Consumer<User>(
                  builder: (ctx, userData, child) =>
                      (userData.user != null && userData.user.level.isNotEmpty)
                          ? (userData.user.level == 'A')
                              ? ApplicantMainScreen()
                              : (userData.user.level == 'R')
                                  ? RecruitmentMainScreen()
                                  : NotFound()
                          : NotFound(),
                ),
    );
  }
}
