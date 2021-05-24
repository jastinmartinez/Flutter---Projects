import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recruitment_app/Helpers/Design/colors_palette.dart';
import 'package:recruitment_app/Models/langauges.dart';
import 'package:recruitment_app/Widgets/Others/exception_handler.dart';
import 'package:recruitment_app/Widgets/Others/show_alert_dialog.dart';

class RecruitmentLanguagesDetail extends StatelessWidget {
  final Function(int) goOtherForm;
  final Function(Languages) languages;
  RecruitmentLanguagesDetail({
    this.languages,
    this.goOtherForm,
  });
  Future<void> _fetchLanguages(BuildContext context) async {
    await Provider.of<Languages>(context, listen: false)
        .fetchLanguages()
        .catchError(
      (onError) {
        ExceptionHandler.erroSnackBar(context, onError);
      },
    );
  }

  Future<void> _deleteLanguages(
      BuildContext context, Languages languages) async {
    await Provider.of<Languages>(context, listen: false)
        .deleteLanguage(languages)
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
                                    itemBuilder: (context, index) => ListTile(
                                      title: Text(languagesData
                                          .getLanguages[index].description),
                                      subtitle: Text(
                                        languagesData.getLanguages[index].state
                                            .toString(),
                                      ),
                                      leading: Text(
                                        (languagesData
                                                .getLanguages[index].index)
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
                                              languages(new Languages(
                                                id: languagesData
                                                    .getLanguages[index].id,
                                                description: languagesData
                                                    .getLanguages[index]
                                                    .description,
                                                state: languagesData
                                                    .getLanguages[index].state,
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
                                                itemName: 'idiomas',
                                                yesFunction: () async =>
                                                    await _deleteLanguages(
                                                  context,
                                                  new Languages(
                                                    id: languagesData
                                                        .getLanguages[index].id,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
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
    );
  }
}
