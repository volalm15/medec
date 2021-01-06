import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medec/login/login.dart';
import 'package:medec/onboarding/components/slide_dots.dart';
import 'package:medec/onboarding/components/slide_item.dart';
import 'package:medec/onboarding/components/slider.dart';

import '../../constants.dart';
import '../../size_config.dart';

class SliderLayoutView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SliderLayoutViewState();
}

class _SliderLayoutViewState extends State<SliderLayoutView> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 0) {
        setState(() {
          _currentPage++;
          _pageController.animateToPage(_currentPage,
              duration: Duration(milliseconds: 200), curve: Curves.easeInCubic);
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Expanded(
            child: PageView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: sliderArrayList.length,
              itemBuilder: (ctx, i) => SlideItem(i),
            ),
          ),
          Container(
            alignment: AlignmentDirectional.bottomCenter,
            margin: EdgeInsets.only(bottom: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                for (int i = 0; i < sliderArrayList.length; i++)
                  if (i == _currentPage) SlideDots(true) else SlideDots(false)
              ],
            ),
          ),
          Container(
            height: size.height * 0.1,
            width: size.width,
            decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    offset: Offset(-5, -5),
                    color: Colors.grey.withOpacity(.3),
                    blurRadius: 20.0, // soften the shadow
                    spreadRadius: 0.0,
                  ) //extend the shadow)
                ],
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: RaisedButton(
                elevation: 5,
                color: primaryColor,
                child: Text("NEXT",
                    style: TextStyle(
                        fontSize: getProportionateScreenHeight(20),
                        color: Colors.white)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () {
                  if (_currentPage < 1) {
                    setState(() {
                      _currentPage++;
                      _pageController.animateToPage(_currentPage,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeInCubic);
                    });
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      )),
    );
  }
}
