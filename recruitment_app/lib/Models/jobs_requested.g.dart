// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobs_requested.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobsRequested _$JobsRequestedFromJson(Map<String, dynamic> json) {
  return JobsRequested(
    id: json['id'] as String,
    userId: json['userId'] as String,
    name: json['name'] as String,
    lastName: json['lastName'] as String,
    phoneNumber: json['phoneNumber'] as String,
    address: json['address'] as String,
    departament: json['departament'] as String,
    salary: json['salary'] as int,
    position: json['position'] as String,
    competition: json['competition'] as String,
    capacitation: json['capacitation'] as String,
    jobsExperience: json['jobsExperience'] as Map<String, dynamic>,
    audit: json['audit'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$JobsRequestedToJson(JobsRequested instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'lastName': instance.lastName,
      'phoneNumber': instance.phoneNumber,
      'address': instance.address,
      'departament': instance.departament,
      'salary': instance.salary,
      'position': instance.position,
      'competition': instance.competition,
      'capacitation': instance.capacitation,
      'jobsExperience': instance.jobsExperience,
      'audit': instance.audit,
    };
