import 'package:firebase_database/firebase_database.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:medec/pages/dashboard/models/gender.dart';
import 'package:medec/pages/dashboard/models/insurance.dart';

part 'patient_model.g.dart';

@JsonSerializable()
class Patient {
  DatabaseReference id;
  final String firstName;
  final String lastName;
  final DateTime dayOfBirth;
  final Gender gender;

  final int postalCode;
  final String city;
  final String street;
  final int svNumber;
  final Insurance insurance;
  final String doctor;

  final bool hasCoInsurance;
  final String coFirstName;
  final String coLastName;
  final DateTime coDayOfBirth;
  final int coSvNumber;
  final Insurance coInsurance;

  Patient(
      this.firstName,
      this.lastName,
      this.dayOfBirth,
      this.gender,
      this.postalCode,
      this.city,
      this.street,
      this.svNumber,
      this.insurance,
      this.doctor,
      this.hasCoInsurance,
      this.coFirstName,
      this.coLastName,
      this.coDayOfBirth,
      this.coSvNumber,
      this.coInsurance);

  factory Patient.fromJson(Map<String, dynamic> json) =>
      _$PatientFromJson(json);
  Map<String, dynamic> toJson() => _$PatientToJson(this);
}
