import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../size_config.dart';
import 'components/slider_layout_view.dart';

class Onboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    uncheckFirstUse();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SliderLayoutView(),
      ),
    );
  }

  Future<void> uncheckFirstUse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('first_use', false);
  }
}
