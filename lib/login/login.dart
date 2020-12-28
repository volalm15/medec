import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:medec/components/background.dart';
import 'package:medec/components/planty_text_form_field.dart';
import 'package:medec/constants.dart';
import 'package:medec/forgotPassword/forgot_password.dart';
import 'package:medec/register/register.dart';

import '../size_config.dart';
import 'util/login_util.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  var _scaffoldState = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldState,
      body: Stack(
        children: [
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Container(
                        width: size.width,
                        child: Column(
                          children: [
                            RichText(
                              text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'WELCOME TO ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              getProportionateScreenHeight(
                                                  30))),
                                  TextSpan(
                                      text: 'MEDEC',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              getProportionateScreenHeight(30)),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {}),
                                ],
                              ),
                              textScaleFactor:
                                  MediaQuery.of(context).textScaleFactor,
                            ),
                            Text(
                              "Get Information About Your Patients",
                              style: TextStyle(
                                fontSize: getProportionateScreenHeight(15),
                                fontWeight: FontWeight.w300,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: RichText(
                          textScaleFactor:
                              MediaQuery.of(context).textScaleFactor,
                          text: TextSpan(
                            style: TextStyle(color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Forgot Password?',
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: getProportionateScreenHeight(15),
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ForgotPassword()),
                                      );
                                    }),
                            ],
                          ),
                        ),
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
                            if (_formKey.currentState.validate()) {
                              signInWithEmailAndPassword(
                                  _emailController.text.replaceAll(" ", ""),
                                  _passwordController.text,
                                  _scaffoldState,
                                  context);
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Text("LOGIN",
                              style: TextStyle(
                                  fontSize: getProportionateScreenHeight(20),
                                  color: Colors.white)),
                        ),
                      ),
                    ),
                    RichText(
                      textScaleFactor: MediaQuery.of(context).textScaleFactor,
                      text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Dont have an account? ',
                              style: TextStyle(
                                fontSize: getProportionateScreenHeight(15),
                              )),
                          TextSpan(
                              text: 'Register',
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: getProportionateScreenHeight(15),
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
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
