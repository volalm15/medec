import 'package:medec/pages/dashboard/models/patient_model.dart';

class Patients {
  List<Patient> _patients;

  List addPatient(Patient patient) {
    _patients.add(patient);
    return _patients;
  }

  List getPatient(int i) {
    _patients.elementAt(i);
    return _patients;
  }

  List removePatient(Patient patient) {
    _patients.remove(patient);
    return _patients;
  }
}
