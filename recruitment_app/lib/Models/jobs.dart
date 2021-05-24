import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

import '../Database/collections.dart';

part 'jobs.g.dart';

enum JobRisk {
  Bajo,
  Medio,
  Alto,
}

enum JobState {
  Disponible,
  Ocupado,
}

@JsonSerializable()
class Jobs extends ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final int amountOfPositions;
  final JobRisk jobRisk;
  final int minSalary;
  final int maxSalary;
  final JobState jobState;
  final Map<String, dynamic> audit;

  Jobs({
    this.id,
    this.title,
    this.description,
    this.amountOfPositions,
    this.jobRisk,
    this.minSalary,
    this.maxSalary,
    this.jobState,
    this.audit,
  });

  Firestore _fireStoreDataBase = Firestore.instance;
  List<Jobs> get jobs => _jobs;
  List<Jobs> _jobs = [];
  List<Jobs> _jobsTemp = [];

  factory Jobs.fromJson(Map<String, dynamic> fromData) =>
      _$JobsFromJson(fromData);

  Map<String, dynamic> toJson(Jobs jobs) => _$JobsToJson(jobs);

  void filterJobsByTitle(String description) {
    if (_jobsTemp.isEmpty) _jobsTemp.addAll(_jobs);
    List<Jobs> jobsDummySearch = List<Jobs>();
    jobsDummySearch.addAll(_jobsTemp);
    if (description.isNotEmpty) {
      List<Jobs> jobsDummyData = List<Jobs>();
      jobsDummySearch.forEach(
        (item) {
          if (item.title.toLowerCase().contains(
                description.toLowerCase(),
              )) {
            jobsDummyData.add(item);
          }
        },
      );
      _jobs.clear();
      _jobs.addAll(jobsDummyData);
    } else {
      _jobs.clear();
      _jobs.addAll(_jobsTemp);
      _jobsTemp.clear();
    }
    notifyListeners();
  }

  Future<void> addJob(Jobs job) async {
    if (job.id != null) {
      await _fireStoreDataBase
          .collection(Collections.jobs)
          .document(
            job.id,
          )
          .setData(
            toJson(
              job,
            ),
          );
      _jobs[_jobs.indexWhere((x) => x.id == job.id)] = job;
    } else {
      await _fireStoreDataBase.collection(Collections.jobs).add(
            toJson(
              job,
            ),
          );
    }
  }

  Stream<List<Jobs>> fetchJobs() {
    return _fireStoreDataBase.collection(Collections.jobs).snapshots().map(
      (jobDocuments) {
        _jobs = jobDocuments.documents
            .map((jobDocument) => Jobs.fromJson(jobDocument.data))
            .toList();
        return _jobs;
      },
    );
  }
}
