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

Patient getPatientFromDataSnapshot(DataSnapshot dataSnapshot) {
  if (dataSnapshot.value != null) {
    Patient patient =
        Patient.fromJson(Map<String, dynamic>.from(dataSnapshot.value));
    patient.id = databaseReference.child('patients/' + dataSnapshot.key);
    return patient;
  }
  throw Exception("DataSnapshot is null");
}
