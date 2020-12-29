import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medec/confirmMail/confirmMail.dart';

import '../../constants.dart';

signInWithEmailAndPassword(String email, String password,
    GlobalKey<ScaffoldState> scaffoldState, BuildContext context) async {
  try {
    User user = (await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user;

    if (!user.emailVerified) {
      scaffoldState.currentState.showSnackBar(SnackBar(
        backgroundColor: primaryColor,
        content: Text("User isnt verified!"),
        action: SnackBarAction(
          label: "Resend",
          textColor: Colors.white,
          onPressed: () {
            user.sendEmailVerification();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ConfirmMail()),
            );
          },
        ),
      ));
    }
  } catch (e) {
    scaffoldState.currentState.showSnackBar(SnackBar(
      content: Text(e.toString()),
      backgroundColor: primaryColor,
    ));
  }
  return null;
}

void registerAccount(String username, String email, String password,
    GlobalKey<ScaffoldState> scaffoldState, BuildContext context) async {
  try {
    final User user =
        (await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ))
            .user;

    await user.sendEmailVerification();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ConfirmMail()),
    );
    await user.updateProfile(displayName: username);
  } catch (e) {
    scaffoldState.currentState.showSnackBar(SnackBar(
      content: Text(e.toString()),
      backgroundColor: primaryColor,
    ));
  }
}

bool isEmail(String em) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = new RegExp(p);

  return regExp.hasMatch(em);
}
