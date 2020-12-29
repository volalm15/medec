import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:medec/pages/dashboard/models/patient_model.dart';

final databaseReference = FirebaseDatabase.instance.reference();
DatabaseReference savePatient(User user, Patient patient) {
  var id = databaseReference.child('patients').push();

  id.set(patient.toJson()).catchError((error, stackTrace) {
    print("outer: $error");
  });
  return id;
}

void updatePatient(Patient patient, DatabaseReference id) {
  id.update(patient.toJson());
}

Future<List<Patient>> getAllPatientsOfUser(User user) async {
  List<Patient> patients = [];
  databaseReference.child('patients').once().then((value) {
    if (value.value != null) {
      value.value.forEach((key, value) {
        Patient patient = Patient.fromJson(value);
        patient.id = databaseReference.child('patients/' + key);
        patients.add(patient);
      });
    }
  });

  return patients;
}
