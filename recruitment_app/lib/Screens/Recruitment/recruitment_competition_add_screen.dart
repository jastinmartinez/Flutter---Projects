import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recruitment_app/Helpers/Design/colors_palette.dart';
import 'package:recruitment_app/Models/competitions.dart';
import 'package:recruitment_app/Widgets/Others/search_box.dart';
import 'package:recruitment_app/Widgets/Recruitment/recruitment_competition_form.dart';

class RecruitmentCompetitionAddScreen extends StatelessWidget {
  Future<void> _fetchCompetitions(BuildContext context) async {
    await Provider.of<Competitions>(context, listen: false).fetchCompetitions();
  }

  Future<void> _filterCompetitionByDescription(
      BuildContext context, String description) async {
    Provider.of<Competitions>(context, listen: false)
        .filterCompetitionByDescription(description);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SearchBox(
            onChanged: (description) =>
                _filterCompetitionByDescription(context, description),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  child: Column(
                    children: [
                      RecruitmentCompetitionForm(),
                      Container(
                        height: 10,
                        color: kBlueColor,
                      ),
                      Expanded(
                        child: FutureBuilder(
                          future: _fetchCompetitions(context),
                          builder: (context, competitionsSnapshot) =>
                              competitionsSnapshot.connectionState ==
                                      ConnectionState.waiting
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        backgroundColor: kSecondaryColor,
                                      ),
                                    )
                                  : RefreshIndicator(
                                      onRefresh: () =>
                                          _fetchCompetitions(context),
                                      child: Consumer<Competitions>(
                                        builder: (ctx, competitionsData,
                                                child) =>
                                            ListView.builder(
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) =>
                                                    ListTile(
                                                      title: Text(
                                                          competitionsData
                                                              .getCompetitions[
                                                                  index]
                                                              .description),
                                                      subtitle: Text(
                                                        competitionsData
                                                            .getCompetitions[
                                                                index]
                                                            .state
                                                            .toString(),
                                                      ),
                                                      leading: Text(
                                                        (competitionsData
                                                                .getCompetitions[
                                                                    index]
                                                                .index)
                                                            .toString(),
                                                      ),
                                                      trailing: Icon(Icons.info,
                                                          color: index.isEven
                                                              ? kBlueColor
                                                              : kSecondaryColor),
                                                    ),
                                                itemCount: competitionsData
                                                    .getCompetitions.length),
                                      ),
                                    ),
                        ),
                      ),
                    ],
                  ),
                  margin: EdgeInsets.only(
                    top: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      bottom: false,
    );
  }
}
