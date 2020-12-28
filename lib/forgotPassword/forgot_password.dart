import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medec/components/planty_text_form_field.dart';

import '../constants.dart';
import '../login/util/login_util.dart';
import '../register/register.dart';
import '../size_config.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = new TextEditingController();
  var _scaffoldState = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldState,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Spacer(),
              SvgPicture.asset(
                "assets/images/forgot.svg",
                height: size.height / 5,
              ),
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Text(
                  "Fill your email and we will send you a link to change your password",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: getProportionateScreenHeight(20),
                      fontWeight: FontWeight.bold),
                ),
              ),
              Spacer(),
              Form(
                key: _formKey,
                child: PlantyTextFormField(
                  prefixIcon: Icons.email,
                  controller: _emailController,
                  hintText: 'Email',
                  isEmail: true,
                  height: getProportionateScreenHeight(20),
                  validator: (String value) {
                    if (!isEmail(value) || value.isEmpty) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
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
                    onPressed: () => {
                      if (_formKey.currentState.validate())
                        {
                          FirebaseAuth.instance.sendPasswordResetEmail(
                              email: _emailController.text.replaceAll(" ", "")),
                        }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35)),
                    child: Text("GET PASSWORD",
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
                        text: 'Dont have an account? ',
                        style: TextStyle(
                            fontSize: getProportionateScreenHeight(15))),
                    TextSpan(
                        text: 'Register',
                        style: TextStyle(
                            fontSize: getProportionateScreenHeight(15),
                            color: primaryColor,
                            fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Register()),
                            );
                          }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
