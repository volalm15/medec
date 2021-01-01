import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medec/database/database.dart';
import 'package:medec/pages/dashboard/models/patient_model.dart';

import 'components/home_body.dart';
import 'components/home_header.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Patient> patients;
  DatabaseReference itemRef;

  @override
  void initState() {
    super.initState();
    final FirebaseDatabase database = FirebaseDatabase
        .instance; //Rather then just writing FirebaseDatabase(), get the instance.
    itemRef = database.reference().child('patients/');
    itemRef.onChildAdded.listen(_onEntryAdded);
    itemRef.onChildChanged.listen(_onEntryChanged);
    itemRef.onChildRemoved.listen(_onEntryDeleted);
    itemRef.onChildMoved.listen(_onEntryMoved);
  }

  _onEntryAdded(Event event) {
    setState(() {
      patients.add(getPatientFromDataSnapshot(event.snapshot));
    });
  }

  _onEntryDeleted(Event event) {
    setState(() {
      var old = patients.singleWhere((entry) {
        return entry.id.key ==
            FirebaseDatabase.instance
                .reference()
                .child('patients/')
                .child(event.snapshot.key)
                .key;
      });
      setState(() {
        patients.removeAt(patients.indexOf(old));
      });
    });
  }

  _onEntryMoved(Event event) {
    throw new UnimplementedError("Error");
  }

  _onEntryChanged(Event event) {
    var old = patients.singleWhere((entry) {
      return entry.id.key ==
          FirebaseDatabase.instance
              .reference()
              .child('patients/')
              .child(event.snapshot.key)
              .key;
    });
    setState(() {
      patients[patients.indexOf(old)] =
          getPatientFromDataSnapshot(event.snapshot);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        slivers: <Widget>[
          HomeHeader(),
          HomeBody(),
          /* FutureBuilder<List<Patient>>(
                future: getAllPatients(),
                builder: (BuildContext futureContext,
                    AsyncSnapshot<List<Patient>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SliverToBoxAdapter(
                      child: Container(
                        height: 50,
                        width: 50,
                        child: Center(
                          child: CircularProgressIndicator(
                            backgroundColor: primaryColor,
                            strokeWidth: 5,
                          ),
                        ),
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData &&
                      snapshot.data != null) {
                    snapshot.data.forEach((element) =>
                        futureContext.watch<List<Patient>>().add(element));
                    return HomeBody();
                  }
                  return SliverToBoxAdapter(
                    child: Text(snapshot.error.toString()),
                  );
                },
              )*/
        ],
      ),
    );
  }
}
