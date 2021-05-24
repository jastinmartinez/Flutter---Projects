import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:recruitment_app/Database/collections.dart';
import 'package:recruitment_app/Models/user.dart';

class Languages extends ChangeNotifier {
  final String id;
  final int index;
  final String description;
  final bool state;
  final Map<String, dynamic> audit;
  Languages({
    this.id,
    this.index,
    this.description,
    this.state,
    this.audit,
  });

  List<Languages> get getLanguages => _getLanguages;
  List<Languages> _getLanguages = [];

  List<Languages> _tempLanguages = [];
  void filterLanguagesByDescription(String description) {
    if (_tempLanguages.isEmpty) {
      _tempLanguages.addAll(_getLanguages);
    }
    List<Languages> competitionsDummySearch = List<Languages>();
    competitionsDummySearch.addAll(_tempLanguages);
    if (description.isNotEmpty) {
      List<Languages> competitionsDummyData = List<Languages>();
      competitionsDummySearch.forEach(
        (item) {
          if (item.description.toLowerCase().contains(
                description.toLowerCase(),
              )) {
            competitionsDummyData.add(item);
          }
        },
      );
      _getLanguages.clear();
      _getLanguages.addAll(competitionsDummyData);
    } else {
      _getLanguages.clear();
      _getLanguages.addAll(_tempLanguages);
      _tempLanguages.clear();
    }
    notifyListeners();
  }

  Future<void> setDataLanguage(Languages extLanguages) async {
    try {
      final userRef = Hive.box('user').getAt(0) as User;
      final date = DateTime.now();

      if (extLanguages.id.isNotEmpty) {
        final languageIndex = _getLanguages.indexWhere(
            (languageToFind) => languageToFind.id == extLanguages.id);
        await Firestore.instance
            .collection(Collections.languages)
            .document(extLanguages.id)
            .setData(
          {
            'description': extLanguages.description,
            'state': extLanguages.state,
            'audit': {
              'createdBy': _getLanguages[languageIndex].audit['createdBy'],
              'createdAt': _getLanguages[languageIndex].audit['createdAt'],
              'modifiedBy': date,
              'modifiedAt': userRef.id
            }
          },
        );
        _getLanguages.insert(languageIndex, extLanguages);
      } else {
        await Firestore.instance.collection(Collections.languages).add(
          {
            'description': extLanguages.description,
            'state': extLanguages.state,
            'audit': {
              'createdBy': userRef.id,
              'createdAt': date,
              'modifiedBy': null,
              'modifiedAt': null,
            }
          },
        );

        final setLanguage = Languages(
          index: _getLanguages.length + 1,
          description: extLanguages.description,
          state: extLanguages.state,
          audit: {
            'createdBy': userRef.id,
            'createdAt': date,
          },
        );
        _getLanguages.add(setLanguage);
      }
      notifyListeners();
    } on PlatformException catch (e) {
      throw e.message;
    }
  }

  Future fetchLanguages() async {
    List<Languages> _tempLanguages = [];
    await Firestore.instance
        .collection(Collections.languages)
        .getDocuments()
        .then(
      (_competitions) {
        _competitions.documents.forEach(
          (_competition) {
            _tempLanguages.add(
              new Languages(
                id: _competition.documentID,
                index: _tempLanguages.length + 1,
                description: _competition.data['description'],
                state: _competition.data['state'],
                audit: _competition.data['audit'],
              ),
            );
          },
        );
        _getLanguages = _tempLanguages;
        notifyListeners();
      },
    );
    notifyListeners();
  }

  Future<void> deleteLanguage(Languages languages) async {
    try {
      await Firestore.instance
          .collection(Collections.languages)
          .document(languages.id)
          .delete();
      final languageIndex = _getLanguages.indexWhere(
          (competitionToFind) => competitionToFind.id == languages.id);
      _getLanguages.removeAt(languageIndex);
      notifyListeners();
    } on PlatformException catch (e) {
      throw e.message;
    }
  }
}
