import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:recruitment_app/Database/collections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recruitment_app/Models/user.dart';

part 'jobs_requested.g.dart';

@JsonSerializable()
class JobsRequested extends ChangeNotifier {
  final String id;
  final String userId;
  final String name;
  final String lastName;
  final String phoneNumber;
  final String address;
  final String departament;
  final int salary;
  final String position;
  final String competition;
  final String capacitation;
  final Map<String, dynamic> jobsExperience;
  final Map<String, dynamic> audit;

  JobsRequested({
    this.id,
    this.userId,
    this.name,
    this.lastName,
    this.phoneNumber,
    this.address,
    this.departament,
    this.salary,
    this.position,
    this.competition,
    this.capacitation,
    this.jobsExperience,
    this.audit,
  });

  factory JobsRequested.fromJson(Map<String, dynamic> fromData) =>
      _$JobsRequestedFromJson(fromData);

  Map<String, dynamic> toJson(JobsRequested jobsRequested) =>
      _$JobsRequestedToJson(jobsRequested);

  List<JobsRequested> _getJobsRequested = [];

  List<JobsRequested> get getJobsRequested {
    return _getJobsRequested;
  }

  Future<void> fetchJobsRequested() async {
    List<JobsRequested> jobsRequestedReceiver = [];

    await Firestore.instance
        .collection(Collections.jobsRequested)
        .where(
          'audit.createdBy',
          isEqualTo: User.userRef,
        )
        .orderBy(
          'audit.createdAt',
          descending: true,
        )
        .getDocuments()
        .then(
      (_jobsrequested) {
        _jobsrequested.documents.forEach(
          (jobsRequested) {
            jobsRequestedReceiver.add(
              JobsRequested.fromJson(
                jobsRequested.data,
              ),
            );
          },
        );
        _getJobsRequested = jobsRequestedReceiver;
        notifyListeners();
      },
    );
  }

  Future<void> addJobRequest(JobsRequested jobRequest) async {
    await Firestore.instance
        .collection(Collections.jobsRequested)
        .document(jobRequest.id)
        .setData(
          toJson(
            jobRequest,
          ),
        )
        .catchError(
          (onError) => print('error'),
        );
    _getJobsRequested.add(jobRequest);
    notifyListeners();
  }
}
