import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:recruitment_app/Database/collections.dart';
import 'package:recruitment_app/Models/user.dart';

class Competitions extends ChangeNotifier {
  final String id, description;
  final bool state;
  final int index;
  final Map<String, dynamic> audit;
  Competitions({
    this.id,
    this.description,
    this.state,
    this.index,
    this.audit,
  });

  List<Competitions> _getCompetitions = [];

  List<Competitions> get getCompetitions {
    return _getCompetitions;
  }

  List<Competitions> _tempCompetitions = [];
  void filterCompetitionByDescription(String description) {
    if (_tempCompetitions.isEmpty) {
      _tempCompetitions.addAll(_getCompetitions);
    }
    List<Competitions> competitionsDummySearch = List<Competitions>();
    competitionsDummySearch.addAll(_tempCompetitions);
    if (description.isNotEmpty) {
      List<Competitions> competitionsDummyData = List<Competitions>();
      competitionsDummySearch.forEach(
        (item) {
          if (item.description.toLowerCase().contains(
                description.toLowerCase(),
              )) {
            competitionsDummyData.add(item);
          }
        },
      );
      _getCompetitions.clear();
      _getCompetitions.addAll(competitionsDummyData);
    } else {
      _getCompetitions.clear();
      _getCompetitions.addAll(_tempCompetitions);
      _tempCompetitions.clear();
    }
    notifyListeners();
  }

  Future<void> setDataCompetition(Competitions competition) async {
    try {
      final userRef = Hive.box('user').getAt(0) as User;
      final date = DateTime.now();

      if (competition.id.isNotEmpty) {
        final competitionIndex = _getCompetitions.indexWhere(
            (competitionToFind) => competitionToFind.id == competition.id);
        await Firestore.instance
            .collection(Collections.competitions)
            .document(competition.id)
            .setData(
          {
            'description': competition.description,
            'state': competition.state,
            'audit': {
              'createdBy':
                  _getCompetitions[competitionIndex].audit['createdBy'],
              'createdAt':
                  _getCompetitions[competitionIndex].audit['createdAt'],
              'modifiedBy': date,
              'modifiedAt': userRef.id
            }
          },
        );
        _getCompetitions.insert(competitionIndex, competition);
      } else {
        await Firestore.instance.collection(Collections.competitions).add(
          {
            'description': competition.description,
            'state': competition.state,
            'audit': {
              'createdBy': userRef.id,
              'createdAt': date,
              'modifiedBy': null,
              'modifiedAt': null,
            }
          },
        );

        final setCompetition = Competitions(
          index: _getCompetitions.length + 1,
          description: competition.description,
          state: competition.state,
          audit: {
            'createdBy': userRef.id,
            'createdAt': date,
          },
        );
        _getCompetitions.add(setCompetition);
      }
      notifyListeners();
    } on PlatformException catch (e) {
      throw e.message;
    }
  }

  Future<void> deleteCompetition(Competitions competition) async {
    try {
      await Firestore.instance
          .collection(Collections.competitions)
          .document(competition.id)
          .delete();
      final oldCompetitionIndex = _getCompetitions.indexWhere(
          (competitionToFind) => competitionToFind.id == competition.id);
      _getCompetitions.removeAt(oldCompetitionIndex);
      notifyListeners();
    } on PlatformException catch (e) {
      throw e.message;
    }
  }

  Future<void> fetchCompetitions() async {
    try {
      List<Competitions> _tempCompetitions = [];
      await Firestore.instance
          .collection(Collections.competitions)
          .getDocuments()
          .then(
        (_competitions) {
          _competitions.documents.forEach(
            (_competition) {
              _tempCompetitions.add(
                new Competitions(
                  id: _competition.documentID,
                  index: _tempCompetitions.length + 1,
                  description: _competition.data['description'],
                  state: _competition.data['state'],
                  audit: _competition.data['audit'],
                ),
              );
            },
          );
          _getCompetitions = _tempCompetitions;
          notifyListeners();
        },
      );
    } on PlatformException catch (e) {
      throw e.message;
    }
  }
}
