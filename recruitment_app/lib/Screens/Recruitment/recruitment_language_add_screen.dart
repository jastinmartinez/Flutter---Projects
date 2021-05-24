import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recruitment_app/Helpers/Design/colors_palette.dart';

import 'package:recruitment_app/Models/langauges.dart';
import 'package:recruitment_app/Widgets/Others/search_box.dart';
import 'package:recruitment_app/Widgets/Recruitment/recruiment_laguages_form.dart';

class RecruitmentLanguageAddScreen extends StatefulWidget {
  @override
  _RecruitmentLanguageAddScreenState createState() =>
      _RecruitmentLanguageAddScreenState();
}

class _RecruitmentLanguageAddScreenState
    extends State<RecruitmentLanguageAddScreen> {
  final descriptionController = new TextEditingController();

  Future<void> _fetchLanguages(BuildContext context) async {
    await Provider.of<Languages>(context, listen: false).fetchLanguages();
  }

  Future<void> _filterLanguagesByDescription(
      BuildContext context, String description) async {
    Provider.of<Languages>(context, listen: false)
        .filterLanguagesByDescription(description);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SearchBox(
            onChanged: (description) =>
                _filterLanguagesByDescription(context, description),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  child: Column(
                    children: [
                      RecruitmentLaguagesForm(),
                      Container(
                        height: 10,
                        color: kBlueColor,
                      ),
                      Expanded(
                        child: FutureBuilder(
                          future: _fetchLanguages(context),
                          builder: (context, competitionsSnapshot) =>
                              competitionsSnapshot.connectionState ==
                                      ConnectionState.waiting
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        backgroundColor: kSecondaryColor,
                                      ),
                                    )
                                  : RefreshIndicator(
                                      onRefresh: () => _fetchLanguages(context),
                                      child: Consumer<Languages>(
                                        builder: (ctx, languagesData, child) =>
                                            ListView.builder(
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) =>
                                              ListTile(
                                            title: Text(languagesData
                                                .getLanguages[index]
                                                .description),
                                            subtitle: Text(
                                              languagesData
                                                  .getLanguages[index].state
                                                  .toString(),
                                            ),
                                            leading: Text(
                                              (languagesData.getLanguages[index]
                                                      .index)
                                                  .toString(),
                                            ),
                                            trailing: Icon(Icons.info,
                                                color: index.isEven
                                                    ? kBlueColor
                                                    : kSecondaryColor),
                                          ),
                                          itemCount:
                                              languagesData.getLanguages.length,
                                        ),
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
