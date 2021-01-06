import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:medec/pages/dashboard/components/add_patient.dart';
import 'package:medec/pages/dashboard/models/insurance.dart';
import 'package:medec/pages/dashboard/models/patient_model.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class HomeBody extends StatefulWidget {
  HomeBody();

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  List<Patient> filteredPatients = [];
  ValueNotifier<String> searchNotifier;
  ValueNotifier<List<Patient>> selectNotifier;
  Patient selectedPatient;

  @override
  Widget build(BuildContext context) {
    searchNotifier = Provider.of<ValueNotifier<String>>(context, listen: true);
    selectNotifier =
        Provider.of<ValueNotifier<List<Patient>>>(context, listen: true);

    TextStyle boldStyle = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: getProportionateScreenHeight(15));
    TextStyle lightStyle = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: getProportionateScreenHeight(13));
    SizeConfig().init(context);
    return ValueListenableBuilder(
        valueListenable: searchNotifier,
        builder: (context, value, _) {
          filteredPatients = selectNotifier.value
              .where((u) => (u.firstName
                      .toLowerCase()
                      .contains(searchNotifier.value.toLowerCase()) ||
                  u.lastName
                      .toLowerCase()
                      .contains(searchNotifier.value.toLowerCase())))
              .toList();

          return SliverFixedExtentList(
            itemExtent:
                getProportionateScreenHeight(70), //// I'm forcing item heights
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                Patient currentPatient = filteredPatients.elementAt(index);
                return ListTile(
                  selectedTileColor: Colors.grey.withOpacity(0.2),
                  selected: selectedPatient == currentPatient ? true : false,
                  onLongPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AddPatient(editablePatient: currentPatient)),
                    );
                  },
                  onTap: () {
                    setState(() {
                      var editMode = false;
                      var patient = filteredPatients[index];
                      if (selectedPatient == patient) {
                        selectedPatient = null;
                      } else {
                        selectedPatient = filteredPatients[index];
                      }
                      //TODO
                    });
                  },
                  trailing: currentPatient == selectedPatient
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
                                          currentPatient.firstName +
                                          " " +
                                          currentPatient.lastName +
                                          "?"),
                                );
                              },
                            );
                          },
                          icon: FaIcon(FontAwesomeIcons.trashAlt))
                      : null,
                  subtitle: Text(
                    currentPatient.street +
                        ", " +
                        currentPatient.postalCode.toString() +
                        " " +
                        currentPatient.city +
                        " | " +
                        insuranceToString(currentPatient.insurance),
                    style: lightStyle,
                  ),
                  title: Text(
                    currentPatient.firstName +
                        " " +
                        currentPatient.lastName +
                        " | " +
                        currentPatient.svNumber.toString() +
                        " " +
                        DateFormat("ddMMyyyy")
                            .format(currentPatient.dayOfBirth),
                    style: boldStyle,
                  ),
                );
              },
              childCount: filteredPatients.length,
            ),
          );
        });
  }
}
