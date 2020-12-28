import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:medec/pages/dashboard/models/patient_model.dart';

DatabaseReference savePatient(User user, Patient patient) {
  final databaseReference = FirebaseDatabase.instance.reference();

  var id = databaseReference.child('Patients').push();

  id.set("fds").catchError((error, stackTrace) {
    // error is SecondError
    print("outer: $error");
  });
  return id;
}

void updatePatient(Patient patient, DatabaseReference id) {
  id.update(patient.toJson());
}

Future<List<Patient>> getAllPatientOfUser(
    User user, DatabaseReference databaseReference) async {
  List<Patient> patients = [];
  databaseReference.child(user.uid + '/' + 'patients/').once().then((value) {
    if (value.value != null) {
      value.value.forEach((key, value) {
        Patient patient = Patient.fromJson(value);
        patient.id =
            databaseReference.child(user.uid + '/' + 'patients/' + key);
        patients.add(patient);
      });
    }
  });

  return patients;
}
