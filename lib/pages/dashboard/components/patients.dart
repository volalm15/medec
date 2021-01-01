import 'package:flutter/cupertino.dart';
import 'package:medec/pages/dashboard/models/patient_model.dart';

class Patients with ChangeNotifier {
  List<Patient> patients = [];

  List<Patient> add(Patient patient) {
    patients.add(patient);
    notifyListeners();
    return patients;
  }

  List<Patient> remove(Patient patient) {
    patients.remove(patient);
    notifyListeners();
    return patients;
  }

  List<Patient> removeByI(int i) {
    patients.remove(i);
    notifyListeners();
    return patients;
  }

  Patient get(int i) {
    Patient patient = patients.elementAt(i);
    notifyListeners();
    return patient;
  }}
