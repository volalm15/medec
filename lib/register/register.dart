import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:medec/components/background.dart';
import 'package:medec/components/planty_text_form_field.dart';
import 'package:medec/constants.dart';
import 'package:medec/login/login.dart';
import 'package:medec/login/util/login_util.dart';

import '../size_config.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _retypedPasswordController =
      new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  var _scaffoldState = new GlobalKey<ScaffoldState>();
  bool savePassword = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldState,
      body: Stack(children: [
        Container(
          height: size.height,
          width: size.width,
          child: new CustomPaint(
            painter: new CircularBackgroundPainter(),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Column(
                      children: [
                        Text(
                          "JOIN COMMUNITY",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: getProportionateScreenHeight(30)),
                        ),
                        Text(
                          "Sign up to our app and explore Medec",
                          style: TextStyle(
                            fontSize: getProportionateScreenHeight(15),
                          ),
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  PlantyTextFormField(
                    prefixIcon: Icons.people,
                    controller: _usernameController,
                    hintText: 'Username',
                    height: getProportionateScreenHeight(20),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter a valid username';
                      }
                      return null;
                    },
                  ),
                  PlantyTextFormField(
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
                  PlantyTextFormField(
                    prefixIcon: Icons.lock,
                    controller: _passwordController,
                    hintText: 'Password',
                    height: getProportionateScreenHeight(20),
                    isPassword: true,
                    validator: (String value) {
                      if (value.length < 7 || value.isEmpty) {
                        return 'Password should be minimum 7 characters';
                      }
                      return null;
                    },
                  ),
                  PlantyTextFormField(
                    prefixIcon: Icons.lock,
                    controller: _retypedPasswordController,
                    hintText: 'Retype Password',
                    isPassword: true,
                    height: getProportionateScreenHeight(20),
                    validator: (value) {
                      if (_passwordController.text !=
                          _retypedPasswordController.text) {
                        return 'Password does not match';
                      }

                      if (value.length < 7 || value.isEmpty) {
                        return 'Password should be minimum 7 characters';
                      }

                      return null;
                    },
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
                          if (_formKey.currentState.validate()) {
                            registerAccount(
                                _usernameController.text,
                                _emailController.text,
                                _passwordController.text,
                                _scaffoldState,
                                context);
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Text("REGISTER",
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
                                  MaterialPageRoute(
                                      builder: (context) => Login()),
                                );
                              }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
