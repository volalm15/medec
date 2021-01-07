import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medec/home/home.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../constants.dart';

class PinDetection extends StatefulWidget {
  @override
  _PinDetectionState createState() => _PinDetectionState();
}

StreamController<ErrorAnimationType> errorController =
    StreamController<ErrorAnimationType>();

class _PinDetectionState extends State<PinDetection> {
  var getPinFlag = false;

  StreamController<ErrorAnimationType> errorController;
  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController textEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    errorController = StreamController<ErrorAnimationType>();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: Text(
                'PIN Verification',
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: defaultPadding, horizontal: 30),
              child: PinCodeTextField(
                backgroundColor: Colors.transparent,
                cursorColor: primaryColor,
                pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(15),
                    fieldHeight: 60,
                    fieldWidth: 50,
                    activeColor: primaryColor2,
                    inactiveColor: primaryColor,
                    borderWidth: 3,
                    selectedColor: primaryColor2,
                    activeFillColor: Colors.white),
                length: 4,
                obscureText: false,
                obscuringCharacter: '*',
                animationType: AnimationType.fade,
                keyboardType: TextInputType.number,
                onCompleted: (v) {
                  getPinFlag = true;
                  FirebaseDatabase.instance
                      .reference()
                      .child('pin')
                      .once()
                      .then((value) {
                    String pin = value.value.toString();
                    if (v == pin) {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                      getPinFlag = false;
                    } else {
                      getPinFlag = false;
                      v = '';
                      errorController.add(ErrorAnimationType.shake);
                    }
                  });
                },
                autovalidateMode: AutovalidateMode.always,
                errorAnimationController: errorController,
                controller: textEditingController,
                animationDuration: Duration(milliseconds: 150),
                pastedTextStyle: TextStyle(
                  color: Colors.green.shade600,
                  fontWeight: FontWeight.bold,
                ),
                appContext: context,
                onChanged: (String value) {},
              ),
            ),
            if (getPinFlag) CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
