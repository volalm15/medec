// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Patient _$PatientFromJson(Map<String, dynamic> json) {
  return Patient(
    json['firstName'] as String,
    json['lastName'] as String,
    json['dayOfBirth'] == null ? null : DateTime.parse(json['dayOfBirth']),
    _$enumDecodeNullable(_$GenderEnumMap, json['gender']),
    json['postalCode'] as int,
    json['city'] as String,
    json['street'] as String,
    json['svNumber'] as int,
    _$enumDecodeNullable(_$InsuranceEnumMap, json['insurance']),
    json['doctor'] as String,
    json['hasCoInsurance'] as bool,
    json['coFirstName'] as String,
    json['coLastName'] as String,
    json['coDayOfBirth'] == null
        ? null
        : DateTime.parse(json['coDayOfBirth'] as String),
    json['coSvNumber'] as int,
    _$enumDecodeNullable(_$InsuranceEnumMap, json['coInsurance']),
  );
}

Map<String, dynamic> _$PatientToJson(Patient instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'dayOfBirth': instance.dayOfBirth?.toIso8601String(),
      'gender': _$GenderEnumMap[instance.gender],
      'postalCode': instance.postalCode,
      'city': instance.city,
      'street': instance.street,
      'svNumber': instance.svNumber,
      'insurance': _$InsuranceEnumMap[instance.insurance],
      'doctor': instance.doctor,
      'hasCoInsurance': instance.hasCoInsurance,
      'coFirstName': instance.coFirstName,
      'coLastName': instance.coLastName,
      'coDayOfBirth': instance.coDayOfBirth?.toIso8601String(),
      'coSvNumber': instance.coSvNumber,
      'coInsurance': _$InsuranceEnumMap[instance.coInsurance],
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

const _$GenderEnumMap = {
  Gender.MALE: 'MALE',
  Gender.FEMALE: 'FEMALE',
};

const _$InsuranceEnumMap = {
  Insurance.GKK: 'GKK',
  Insurance.BVAEB: 'BVAEB',
  Insurance.BVAOEB: 'BVAOEB',
  Insurance.SVSLW: 'SVSLW',
};
