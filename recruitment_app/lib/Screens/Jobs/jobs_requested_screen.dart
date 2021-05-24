import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:recruitment_app/Helpers/Design/colors_palette.dart';
import 'package:recruitment_app/Models/jobs_requested.dart';
import 'package:recruitment_app/Widgets/Jobs/jobs_requested_card.dart';

class JobsRequestedScreen extends StatelessWidget {
  Future<void> _getJobsRequested(BuildContext context) async {
    await Provider.of<JobsRequested>(context, listen: false)
        .fetchJobsRequested();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Container(
                child: Stack(
                  children: [
                    Positioned(
                      left: 150,
                      child: SvgPicture.asset(
                        'assets/icons/owl.svg',
                        height: 100,
                        width: 100,
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: FutureBuilder(
                        future: _getJobsRequested(context),
                        builder: (context, jobsRequestedSnapshot) {
                          return jobsRequestedSnapshot.connectionState ==
                                  ConnectionState.waiting
                              ? Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: kSecondaryColor,
                                  ),
                                )
                              : RefreshIndicator(
                                  onRefresh: () => _getJobsRequested(context),
                                  child: Consumer<JobsRequested>(
                                    builder: (ctx, jobsRequestedData, child) =>
                                        GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1,
                                        mainAxisSpacing: 0,
                                      ),
                                      itemBuilder: (context, index) =>
                                          JobsRequestedCard(
                                        index: index,
                                        id: jobsRequestedData
                                            .getJobsRequested[index].id,
                                        name: jobsRequestedData
                                            .getJobsRequested[index].name,
                                        lastName: jobsRequestedData
                                            .getJobsRequested[index].lastName,
                                        capacitations: jobsRequestedData
                                            .getJobsRequested[index]
                                            .capacitation,
                                        competitions: jobsRequestedData
                                            .getJobsRequested[index]
                                            .competition,
                                        address: jobsRequestedData
                                            .getJobsRequested[index].address,
                                        salary: jobsRequestedData
                                            .getJobsRequested[index].salary,
                                        position: jobsRequestedData
                                            .getJobsRequested[index].position,
                                        departament: jobsRequestedData
                                            .getJobsRequested[index]
                                            .departament,
                                        phoneNumber: jobsRequestedData
                                            .getJobsRequested[index]
                                            .phoneNumber,
                                        createdAt: (jobsRequestedData
                                            .getJobsRequested[index]
                                            .audit['createdAt']),
                                      ),
                                      itemCount: jobsRequestedData
                                          .getJobsRequested.length,
                                    ),
                                  ),
                                );
                        },
                      ),
                      margin: EdgeInsets.only(
                        top: 100,
                        left: 5,
                        right: 5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      bottom: false,
    );
  }
}
