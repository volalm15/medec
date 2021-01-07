import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medec/components/search_field.dart';
import 'package:medec/login/login.dart';
import 'package:medec/pages/dashboard/models/patient_model.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({
    Key key,
  }) : super(key: key);

  @override
  HomeHeaderState createState() => HomeHeaderState();
}

class HomeHeaderState extends State<HomeHeader> {
  ValueNotifier<String> searchNotifier;
  ValueNotifier<List<Patient>> selectNotifier;
  bool _editMode = false;
  void editModeCallback(bool value) {
    _editMode = value;
  }

  User user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    // Provider.of<Patient>(context, listen: false).setX = 'Set to new value';
  }

  @override
  Widget build(BuildContext context) {
    selectNotifier =
        Provider.of<ValueNotifier<List<Patient>>>(context, listen: true);
    searchNotifier = Provider.of<ValueNotifier<String>>(context, listen: true);
    return SliverAppBar(
      pinned: false,
      floating: true,
      stretch: true,
      snap: true,
      expandedHeight: getProportionateScreenHeight(220),
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: [StretchMode.blurBackground, StretchMode.fadeTitle],
        background: Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Stack(
            overflow: Overflow.visible,
            alignment: Alignment.center,
            children: [
              Material(
                elevation: 10,
                child: Container(
                  color: primaryColor,
                  width: double.infinity,
                  height: getProportionateScreenHeight(220),
                ),
              ),
              Positioned(
                  top: 0,
                  right: 0,
                  child: Column(
                    children: [
                      SafeArea(
                        child: Material(
                          elevation: 10,
                          color: primaryColor2,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              topLeft: Radius.circular(20)),
                          child: IconButton(
                              splashRadius: 20,
                              icon: Icon(
                                Icons.logout,
                                color: Colors.white,
                                size: getProportionateScreenHeight(25),
                              ),
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
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          icon: FaIcon(
                                            FontAwesomeIcons.times,
                                            size: getProportionateScreenHeight(
                                                20),
                                          ),
                                          label: Text('Cancel'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        RaisedButton.icon(
                                          color: primaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          icon: FaIcon(
                                            FontAwesomeIcons.check,
                                            size: getProportionateScreenHeight(
                                                20),
                                          ),
                                          label: Text('Confirm'),
                                          onPressed: () {
                                            setState(() {
                                              FirebaseAuth.instance.signOut();
                                              Navigator.of(context).pop();
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Login()),
                                              );
                                            });
                                          },
                                        ),
                                      ],
                                      content:
                                          Text("Do you really want do logout?"),
                                    );
                                  },
                                );
                              }),
                        ),
                      ),
                      AnimatedOpacity(
                        opacity: _editMode ? 1.0 : 0.0,
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeInExpo,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: defaultPadding, top: defaultPadding),
                          child: Material(
                            elevation: 10,
                            color: primaryColor2,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20)),
                            child: IconButton(
                                splashRadius: 20,
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: getProportionateScreenHeight(25),
                                ),
                                onPressed: () {}),
                          ),
                        ),
                      ),
                    ],
                  )),
              SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Medec",
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(50),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 0.5),
                    ),
                    Text(
                      "Welcome " + user.email,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: getProportionateScreenWidth(-25),
                child: SearchField((value) {
                  setState(() {
                    searchNotifier.value = value;
                  });
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
