import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recruitment_app/Helpers/Design/colors_palette.dart';
import 'package:recruitment_app/Models/competitions.dart';
import 'package:recruitment_app/Widgets/Others/exception_handler.dart';
import 'package:recruitment_app/Widgets/Others/show_alert_dialog.dart';

class CompetitionDetail extends StatelessWidget {
  CompetitionDetail({
    this.competitions,
    this.goOtherForm,
  });
  final Function(int) goOtherForm;
  final Function(Competitions) competitions;

  Future<void> _fetchCompetitions(BuildContext context) async {
    await Provider.of<Competitions>(context, listen: false)
        .fetchCompetitions()
        .catchError(
      (onError) {
        ExceptionHandler.erroSnackBar(context, onError);
      },
    );
  }

  Future<void> _deleteCompetition(
      BuildContext context, Competitions competition) async {
    await Provider.of<Competitions>(context, listen: false)
        .deleteCompetition(competition)
        .catchError(
      (onError) {
        ExceptionHandler.erroSnackBar(context, onError);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
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
                                onRefresh: () => _fetchCompetitions(context),
                                child: Consumer<Competitions>(
                                  builder: (ctx, competitionsData, child) =>
                                      ListView.builder(
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) => ListTile(
                                      title: Text(competitionsData
                                          .getCompetitions[index].description),
                                      subtitle: Text(
                                        competitionsData
                                            .getCompetitions[index].state
                                            .toString(),
                                      ),
                                      leading: Text(
                                        (competitionsData
                                                .getCompetitions[index].index)
                                            .toString(),
                                      ),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.edit,
                                              color: kSecondaryColor,
                                            ),
                                            onPressed: () {
                                              competitions(new Competitions(
                                                id: competitionsData
                                                    .getCompetitions[index].id,
                                                description: competitionsData
                                                    .getCompetitions[index]
                                                    .description,
                                                state: competitionsData
                                                    .getCompetitions[index]
                                                    .state,
                                              ));
                                              goOtherForm(1);
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.delete,
                                                color: Colors.red),
                                            onPressed: () {
                                              Provider.of<ShowAlertDialog>(
                                                      context,
                                                      listen: false)
                                                  .showAlertDialog(
                                                context: context,
                                                action: 'eliminar',
                                                alertName: 'Elminacion',
                                                itemName: 'competencias',
                                                yesFunction: () async =>
                                                    await _deleteCompetition(
                                                  context,
                                                  new Competitions(
                                                    id: competitionsData
                                                        .getCompetitions[index]
                                                        .id,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    itemCount:
                                        competitionsData.getCompetitions.length,
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
    );
  }
}
