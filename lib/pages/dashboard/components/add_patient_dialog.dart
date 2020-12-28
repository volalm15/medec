import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:medec/components/planty_dropdown_form_field.dart';
import 'package:medec/components/planty_text_form_field.dart';
import 'package:medec/constants.dart';
import 'package:medec/database/database.dart';
import 'package:medec/pages/dashboard/models/gender.dart';
import 'package:medec/pages/dashboard/models/insurance.dart';
import 'package:medec/pages/dashboard/models/patient_model.dart';
import 'package:medec/size_config.dart';

class AddPatientDialog extends StatefulWidget {
  @override
  _AddPatientDialogState createState() => _AddPatientDialogState();
}

List<GlobalKey<FormState>> _formKeys = [
  GlobalKey<FormState>(),
  GlobalKey<FormState>(),
  GlobalKey<FormState>(),
];

class _AddPatientDialogState extends State<AddPatientDialog> {
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController dayOfBirthController = new TextEditingController();
  TextEditingController postalCodeController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController streetController = new TextEditingController();
  TextEditingController svNumberController = new TextEditingController();
  TextEditingController insuranceController = new TextEditingController();
  TextEditingController doctorController = new TextEditingController();

  TextEditingController coFirstNameController = new TextEditingController();
  TextEditingController coLastNameController = new TextEditingController();
  TextEditingController coDayOfBirthController = new TextEditingController();
  TextEditingController coSvNumberController = new TextEditingController();
  TextEditingController coInsuranceController = new TextEditingController();

  int currentStep = 0;

  Gender _genderValue = Gender.MALE;

  Insurance _insuranceValue = Insurance.GKK;

  bool _coInsurance = false;
  bool _complete = false;

  Insurance _coInsuranceValue = Insurance.GKK;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Step> steps = [
      Step(
          title: Text("General Patient Data"),
          subtitle: Text("Name - Day Of Birth - Gender"),
          content: Form(
            child: Column(
              children: [
                PlantyTextFormField(
                  hintText: "First Name",
                  controller: firstNameController,
                  prefixIcon: FontAwesomeIcons.idCard,
                  height: getProportionateScreenHeight(10),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'First name could not be empty';
                    }
                    return null;
                  },
                ),
                PlantyTextFormField(
                  controller: lastNameController,
                  hintText: "Last Name",
                  prefixIcon: FontAwesomeIcons.idCard,
                  height: getProportionateScreenHeight(10),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Last name could not be empty';
                    }
                    return null;
                  },
                ),
                PlantyTextFormField(
                  controller: dayOfBirthController,
                  hintText: "Day of Birth",
                  prefixIcon: FontAwesomeIcons.calendarAlt,
                  height: getProportionateScreenHeight(10),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Day of birth could not be empty';
                    }
                    return null;
                  },
                  focusNode: NoKeyboardEditableTextFocusNode(),
                  onTap: () {
                    setState(() {
                      buildMaterialDatePicker(context).then((value) =>
                          dayOfBirthController.text =
                              DateFormat.yMd().format(value));
                    });
                  },
                ),
                PlantyDropdownFormField<Gender>(
                  prefixIcon: FontAwesomeIcons.userAlt,
                  value: _genderValue,
                  height: getProportionateScreenHeight(10),
                  choices: Gender.values
                      .map<DropdownMenuItem<Gender>>((Gender gender) {
                    return DropdownMenuItem<Gender>(
                      value: gender,
                      child: Text(genderToString(gender)),
                    );
                  }).toList(),
                  onChanged: (Gender newValue) {
                    setState(() {
                      _genderValue = newValue;
                    });
                  },
                ),
                PlantyTextFormField(
                  controller: postalCodeController,
                  height: getProportionateScreenHeight(10),
                  isNumber: true,
                  inputFormatter: [
                    LengthLimitingTextInputFormatter(4),
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Postal code number could not be empty';
                    }
                    if (value.length != 4) {
                      return 'Postal code number is too short';
                    }
                    return null;
                  },
                  hintText: "Postal-Code",
                  prefixIcon: FontAwesomeIcons.city,
                ),
                PlantyTextFormField(
                  controller: cityController,
                  hintText: "City",
                  prefixIcon: FontAwesomeIcons.idCard,
                  height: getProportionateScreenHeight(10),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'City could not be empty';
                    }
                    return null;
                  },
                ),
                PlantyTextFormField(
                  controller: streetController,
                  hintText: "Street",
                  prefixIcon: FontAwesomeIcons.idCard,
                  height: getProportionateScreenHeight(10),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Street could not be empty';
                    }
                    return null;
                  },
                ),
              ],
            ),
            key: _formKeys[0],
          )),
      Step(
          title: Text("Medical Data"),
          subtitle: Text("Insurance Number - Institute"),
          content: Form(
            child: Column(
              children: [
                PlantyTextFormField(
                  controller: svNumberController,
                  height: getProportionateScreenHeight(10),
                  isNumber: true,
                  inputFormatter: [
                    LengthLimitingTextInputFormatter(4),
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'SV number could not be empty';
                    }
                    if (value.length != 4) {
                      return 'SV number is too short';
                    }
                    return null;
                  },
                  hintText: "SV-Number",
                  prefixIcon: FontAwesomeIcons.hospitalUser,
                ),
                PlantyDropdownFormField<Insurance>(
                  prefixIcon: FontAwesomeIcons.hospitalAlt,
                  value: _insuranceValue,
                  height: getProportionateScreenHeight(10),
                  choices: Insurance.values
                      .map<DropdownMenuItem<Insurance>>((Insurance insurance) {
                    return DropdownMenuItem<Insurance>(
                      value: insurance,
                      child: Text(insuranceToString(insurance)),
                    );
                  }).toList(),
                  onChanged: (Insurance newValue) {
                    setState(() {
                      _insuranceValue = newValue;
                    });
                  },
                ),
                PlantyTextFormField(
                  controller: doctorController,
                  hintText: "Doctor",
                  prefixIcon: FontAwesomeIcons.idCard,
                  height: getProportionateScreenHeight(10),
                ),
                Row(
                  children: [
                    Checkbox(
                        value: _coInsurance,
                        onChanged: (value) {
                          setState(() {
                            _coInsurance = value;
                          });
                        }),
                    Text(
                      "Co-Insurance",
                      style:
                          TextStyle(fontSize: getProportionateScreenHeight(15)),
                    ),
                  ],
                )
              ],
            ),
            key: _formKeys[1],
          )),
      Step(
          title: Text("Co-Insurance"),
          state: _coInsurance ? StepState.indexed : StepState.disabled,
          subtitle: Text("Name - Day Of Birth - Gender"),
          content: Form(
            child: Column(
              children: [
                PlantyTextFormField(
                  hintText: "First Name",
                  prefixIcon: FontAwesomeIcons.idCard,
                  height: getProportionateScreenHeight(10),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'First name could not be empty';
                    }
                    return null;
                  },
                ),
                PlantyTextFormField(
                  hintText: "Last Name",
                  prefixIcon: FontAwesomeIcons.idCard,
                  height: getProportionateScreenHeight(10),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Last name could not be empty';
                    }
                    return null;
                  },
                ),
                PlantyTextFormField(
                  controller: dayOfBirthController,
                  hintText: "Day of Birth",
                  prefixIcon: FontAwesomeIcons.calendarAlt,
                  height: getProportionateScreenHeight(10),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Day of birth could not be empty';
                    }
                    return null;
                  },
                  focusNode: NoKeyboardEditableTextFocusNode(),
                  onTap: () {
                    setState(() {
                      buildMaterialDatePicker(context).then((value) =>
                          dayOfBirthController.text =
                              DateFormat.yMd().format(value));
                    });
                  },
                ),
                PlantyTextFormField(
                  height: getProportionateScreenHeight(10),
                  isNumber: true,
                  inputFormatter: [
                    LengthLimitingTextInputFormatter(4),
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'SV number could not be empty';
                    }
                    if (value.length != 4) {
                      return 'SV number is too short';
                    }
                    return null;
                  },
                  hintText: "SV-Number",
                  prefixIcon: FontAwesomeIcons.hospitalUser,
                ),
                PlantyDropdownFormField<Insurance>(
                  prefixIcon: FontAwesomeIcons.hospitalAlt,
                  value: _coInsuranceValue,
                  height: getProportionateScreenHeight(10),
                  choices: Insurance.values
                      .map<DropdownMenuItem<Insurance>>((Insurance insurance) {
                    return DropdownMenuItem<Insurance>(
                      value: insurance,
                      child: Text(insuranceToString(insurance)),
                    );
                  }).toList(),
                  onChanged: (Insurance newValue) {
                    setState(() {
                      _coInsuranceValue = newValue;
                    });
                  },
                ),
              ],
            ),
            key: _formKeys[2],
          )),
    ];

    goTo(int step) {
      setState(() => currentStep = step);
    }

    next() {
      if (_formKeys[currentStep].currentState.validate()) {
        if (!_coInsurance && currentStep == 1) {
          setState(() => _complete = true);
        } else if (currentStep + 1 != steps.length) {
          goTo(currentStep + 1);
        } else {
          setState(() => _complete = true);
        }
      }
    }

    cancel() {
      if (currentStep > 0) {
        goTo(currentStep - 1);
      }
    }

    return AlertDialog(
      title: Text("Add Patient"),
      content: Container(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
            child: Stepper(
                physics: BouncingScrollPhysics(),
                currentStep: currentStep,
                steps: steps,
                onStepCancel: cancel,
                onStepContinue: next,
                onStepTapped: (step) =>
                    _formKeys[currentStep].currentState.validate() ??
                    goTo(step),
                controlsBuilder: (BuildContext context,
                    {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                  return Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Row(
                      children: [
                        Material(
                            color: primaryColorDark,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              height: getProportionateScreenHeight(40),
                              width: getProportionateScreenWidth(60),
                              child: IconButton(
                                onPressed: onStepContinue,
                                icon: FaIcon(
                                  FontAwesomeIcons.arrowDown,
                                  size: getProportionateScreenHeight(20),
                                  color: Colors.white,
                                ),
                              ),
                            )),
                        if (currentStep >= 1)
                          Material(
                              color: primaryColorDark,
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                width: getProportionateScreenWidth(60),
                                height: getProportionateScreenHeight(40),
                                child: IconButton(
                                  onPressed: onStepCancel,
                                  icon: FaIcon(
                                    FontAwesomeIcons.arrowUp,
                                    size: getProportionateScreenHeight(20),
                                    color: Colors.white,
                                  ),
                                ),
                              )),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    ),
                  );
                })),
      ),
      actions: <Widget>[
        RaisedButton.icon(
          color: primaryColorDark,
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
        AnimatedOpacity(
          opacity: _complete ? 1.0 : 0.0,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInExpo,
          child: RaisedButton.icon(
            color: primaryColorDark,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            icon: FaIcon(FontAwesomeIcons.plus,
                size: getProportionateScreenHeight(20)),
            label: Text('Add Patient'),
            onPressed: () {
              createPatient();
              Navigator.of(context).pop();
            },
          ),
        )
      ],
    );
  }

  void createPatient() {
    final String firstName = firstNameController.text;
    final String lastName = lastNameController.text;
    final DateTime dayOfBirth =
        DateFormat.yMd().parse(dayOfBirthController.text);
    final Gender gender = _genderValue;
    final int postalCode = int.parse(postalCodeController.text);
    final String city = cityController.text;
    final String street = streetController.text;
    final int svNumber = int.parse(svNumberController.text);
    final Insurance insurance = _insuranceValue;
    final String doctor = doctorController.text;
    final bool hasCoInsurance = _coInsurance;

    String coFirstName = "";
    String coLastName = "";
    DateTime coDayOfBirth = DateTime.now();
    int coSvNumber = 0;
    Insurance coInsurance = Insurance.GKK;
    if (_coInsurance) {
      coFirstName = coFirstNameController.text;
      coLastName = coLastNameController.text;
      coDayOfBirth = DateTime.parse(coDayOfBirthController.text);
      coSvNumber = int.parse(coSvNumberController.text);
      coInsurance = insuranceToString(_coInsuranceValue);
    }

    final Patient patient = new Patient(
        firstName,
        lastName,
        dayOfBirth,
        gender,
        postalCode,
        city,
        street,
        svNumber,
        insurance,
        doctor,
        hasCoInsurance,
        coFirstName,
        coLastName,
        coDayOfBirth,
        coSvNumber,
        coInsurance);

    patient.id = savePatient(FirebaseAuth.instance.currentUser, patient);
  }
}

Future<DateTime> buildMaterialDatePicker(BuildContext context) async {
  DateTime initialDate = DateTime.now();
  final DateTime picked = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(2000),
    lastDate: DateTime(2025),
    builder: (context, child) {
      return Theme(
        data: ThemeData.dark(),
        child: child,
      );
    },
  );
  if (picked != null && picked != initialDate) return picked;

  return initialDate;
}
