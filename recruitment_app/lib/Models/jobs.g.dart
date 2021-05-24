// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Jobs _$JobsFromJson(Map<String, dynamic> json) {
  return Jobs(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    amountOfPositions: json['amountOfPositions'] as int,
    jobRisk: _$enumDecodeNullable(_$JobRiskEnumMap, json['jobRisk']),
    minSalary: json['minSalary'] as int,
    maxSalary: json['maxSalary'] as int,
    jobState: _$enumDecodeNullable(_$JobStateEnumMap, json['jobState']),
    audit: json['audit'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$JobsToJson(Jobs instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'amountOfPositions': instance.amountOfPositions,
      'jobRisk': _$JobRiskEnumMap[instance.jobRisk],
      'minSalary': instance.minSalary,
      'maxSalary': instance.maxSalary,
      'jobState': _$JobStateEnumMap[instance.jobState],
      'audit': instance.audit,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$JobRiskEnumMap = {
  JobRisk.Bajo: 'Bajo',
  JobRisk.Medio: 'Medio',
  JobRisk.Alto: 'Alto',
};

const _$JobStateEnumMap = {
  JobState.Disponible: 'Disponible',
  JobState.Ocupado: 'Ocupado',
};
