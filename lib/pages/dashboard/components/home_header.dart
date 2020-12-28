import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medec/components/search_field.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'add_patient_dialog.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({
    Key key,
  }) : super(key: key);

  @override
  _HomeHeaderState createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  bool _editMode = false;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false,
      floating: true,
      stretch: true,
      snap: true,
      expandedHeight: getProportionateScreenHeight(220),
      shadowColor: Colors.white,
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
                          child: Column(
                            children: [
                              IconButton(
                                  splashRadius: 20,
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: getProportionateScreenHeight(25),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      showMaterialDialog();
                                    });
                                  }),
                              IconButton(
                                  splashRadius: 20,
                                  icon: Icon(
                                    Icons.logout,
                                    color: Colors.white,
                                    size: getProportionateScreenHeight(25),
                                  ),
                                  onPressed: () {
                                    FirebaseAuth.instance.signOut();
                                  })
                            ],
                          ),
                        ),
                      ),
                      AnimatedOpacity(
                        opacity: true ? 1.0 : 0.0,
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
                      "Welcome " + FirebaseAuth.instance.currentUser.email,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: getProportionateScreenWidth(-25),
                child: SearchField(),
              )
            ],
          ),
        ),
      ),
    );
  }

  showMaterialDialog() {
    showDialog(context: context, builder: (_) => AddPatientDialog());
  }
}
