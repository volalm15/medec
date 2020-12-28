import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medec/onboarding/components/slider.dart';

import '../../constants.dart';
import '../../size_config.dart';

class SlideItem extends StatelessWidget {
  final int index;
  SlideItem(this.index);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              child: SvgPicture.asset(sliderArrayList[index].sliderImageUrl),
            ),
            Column(children: <Widget>[
              Text(
                sliderArrayList[index].sliderHeading,
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(30),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Text(
                    sliderArrayList[index].sliderSubHeading,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: getProportionateScreenHeight(15),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
