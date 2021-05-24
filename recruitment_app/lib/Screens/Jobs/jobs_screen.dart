import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recruitment_app/Helpers/Design/colors_palette.dart';
import 'package:recruitment_app/Models/jobs.dart';
import 'package:recruitment_app/Screens/Jobs/job_request_screen.dart';
import 'package:recruitment_app/Widgets/Jobs/job_card.dart';
import 'package:recruitment_app/Widgets/Others/search_box.dart';
import 'package:provider/provider.dart';

class JobsScreen extends StatefulWidget {
  @override
  _JobsScreenState createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  Stream _getJobs(BuildContext context) {
    return Provider.of<Jobs>(context, listen: false).fetchJobs();
  }

  void _filterJobsByTitle(BuildContext contex, String value) {
    Provider.of<Jobs>(context, listen: false).filterJobsByTitle(value);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SearchBox(
            onChanged: (value) => _filterJobsByTitle(
              context,
              value,
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                child: Stack(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/owl.svg',
                      height: 100,
                      width: 100,
                    ),
                    Container(
                      child: StreamBuilder(
                        stream: _getJobs(context),
                        builder: (context, jobsnapshot) =>
                            jobsnapshot.connectionState ==
                                    ConnectionState.waiting
                                ? Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor: kSecondaryColor,
                                    ),
                                  )
                                : ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        SizedBox(),
                                    itemBuilder: (_, index) => GestureDetector(
                                      onDoubleTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              JobRequestScreen(
                                            job: jobsnapshot.data[index],
                                          ),
                                        ),
                                      ),
                                      child: JobCard(
                                        index: index,
                                        id: jobsnapshot.data[index].id,
                                        title: jobsnapshot.data[index].title,
                                        minSalary:
                                            jobsnapshot.data[index].minSalary,
                                        maxSalary:
                                            jobsnapshot.data[index].maxSalary,
                                        createdAt: jobsnapshot
                                            .data[index].audit['createdAt']
                                            .toDate(),
                                      ),
                                    ),
                                    itemCount: jobsnapshot.data.length,
                                  ),
                      ),
                      margin: EdgeInsets.only(top: 70),
                      decoration: BoxDecoration(
                        color: kBackgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottom: false,
    );
  }
}
