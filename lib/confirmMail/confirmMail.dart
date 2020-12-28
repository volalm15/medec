import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medec/login/login.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import '../size_config.dart';

class ConfirmMail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Spacer(),
            SvgPicture.asset(
              "assets/images/confirm.svg",
              height: size.height / 5,
            ),
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Text(
                "We sent you an email to verify your account",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: getProportionateScreenHeight(30),
                    fontWeight: FontWeight.bold),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Container(
                height: getProportionateScreenHeight(55),
                width: size.width,
                child: RaisedButton(
                  color: primaryColor,
                  elevation: 10,
                  onPressed: () {
                    if (Platform.isAndroid) {
                      AndroidIntent intent = AndroidIntent(
                        action: 'android.intent.action.MAIN',
                        category: 'android.intent.category.APP_EMAIL',
                      );
                      intent.launch().catchError((e) {
                        ;
                      });
                    } else if (Platform.isIOS) {
                      launch("message://").catchError((e) {
                        ;
                      });
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text("OPEN MAIL",
                      style: TextStyle(
                          fontSize: getProportionateScreenHeight(20),
                          color: Colors.white)),
                ),
              ),
            ),
            RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(
                        fontSize: getProportionateScreenHeight(15),
                      )),
                  TextSpan(
                      text: 'Login',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: getProportionateScreenHeight(15),
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
