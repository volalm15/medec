import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:medec/constants.dart';
import 'package:medec/pages/dashboard/models/gender.dart';
import 'package:medec/pages/dashboard/models/insurance.dart';
import 'package:medec/pages/dashboard/models/patient_model.dart';
import 'package:provider/provider.dart';

import '../../../size_config.dart';

class HomeBody extends StatefulWidget {
  HomeBody();

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  Patient selectedPatient;
  List<Patient> patients = [];

  @override
  Widget build(BuildContext context) {
    patients = Provider.of<List<Patient>>(context);
    TextStyle boldStyle = TextStyle(fontWeight: FontWeight.bold);
    SizeConfig().init(context);
    return SliverFixedExtentList(
      itemExtent:
          getProportionateScreenHeight(70), //// I'm forcing item heights
      delegate: SliverChildBuilderDelegate(
        (context, index) => ListTile(
          selectedTileColor: Colors.grey.withOpacity(0.2),
          selected: selectedPatient == patients.elementAt(index) ? true : false,
          onTap: () {
            setState(() {
              var editMode = false;
              var patient = patients[index];
              if (selectedPatient == patient) {
                selectedPatient = null;
              } else {
                selectedPatient = patients[index];
              }
              //TODO
            });
          },
          trailing: patients.elementAt(index) == selectedPatient
              ? IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return new AlertDialog(
                          title: Text("Attention"),
                          actions: [
                            RaisedButton.icon(
                              color: primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              icon: FaIcon(
                                FontAwesomeIcons.trashAlt,
                                size: getProportionateScreenHeight(20),
                              ),
                              label: Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            RaisedButton.icon(
                              color: primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              icon: FaIcon(
                                FontAwesomeIcons.trashAlt,
                                size: getProportionateScreenHeight(20),
                              ),
                              label: Text('Confirm'),
                              onPressed: () {
                                setState(() {
                                  FirebaseDatabase.instance
                                      .reference()
                                      .child('patients/')
                                      .child(selectedPatient.id.key)
                                      .remove()
                                      .then((value) {
                                    selectedPatient = null;
                                    Navigator.of(context).pop();
                                  }).catchError((error, stackTrace) {
                                    print("outer: $error");
                                  });
                                });
                              },
                            ),
                          ],
                          content: Text(
                              "Do you really want do delete the patient " +
                                  patients.elementAt(index).firstName +
                                  " " +
                                  patients.elementAt(index).lastName +
                                  "?"),
                        );
                      },
                    );
                  },
                  icon: FaIcon(FontAwesomeIcons.trashAlt))
              : null,
          subtitle: Text(patients.elementAt(index).street +
              ", " +
              patients.elementAt(index).postalCode.toString() +
              " " +
              patients.elementAt(index).city),
          title: Text(
            patients.elementAt(index).firstName +
                " " +
                patients.elementAt(index).lastName +
                " ❘ " +
                genderToString(patients.elementAt(index).gender) +
                " | " +
                patients.elementAt(index).svNumber.toString() +
                " " +
                DateFormat("ddMMyyyy")
                    .format(patients.elementAt(index).dayOfBirth) +
                " | " +
                insuranceToString(patients.elementAt(index).insurance),
            style: boldStyle,
          ),
        ),
        childCount: patients.length,
      ),
    );
  }
}
