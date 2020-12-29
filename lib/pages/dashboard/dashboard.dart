import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medec/database/database.dart';

import '../../constants.dart';
import 'components/home_header.dart';
import 'models/patient_model.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool _dataLoaded = false;

  List<Patient> patients = [];
  @override
  Widget build(BuildContext context) {
    final generatedList = List.generate(500, (index) => 'Item $index');
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        slivers: <Widget>[
          HomeHeader(),
          !_dataLoaded
              ? FutureBuilder<List<Patient>>(
                  future:
                      getAllPatientsOfUser(FirebaseAuth.instance.currentUser),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Patient>> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
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
                      case ConnectionState.active:
                        {
                          patients = snapshot.data;
                          _dataLoaded = true;
                          return Dashboard();
                        }

                      default:
                        return Text('Error: ${snapshot.error}');
                    }
                  },
                )
              : SliverFixedExtentList(
                  itemExtent: 50, // I'm forcing item heights
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => ListTile(
                      title: Text(
                        patients[index].firstName + patients[index].lastName,
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                    childCount: patients.length,
                  ),
                ),
        ],
      ),
    );
  }
}
