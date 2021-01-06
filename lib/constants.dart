import 'dart:ui';

import 'package:flutter/material.dart';

class Constants {
  static const String POPPINS = "Poppins";
  static const String OPEN_SANS = "OpenSans";
  static const String SKIP = "Skip";
  static const String NEXT = "Next";
  static const String SLIDER_HEADING_1 = "Watering without worry!";
  static const String SLIDER_HEADING_2 = "Get Information About Your Plants!";
  static const String SLIDER_HEADING_3 = "Build & Share with Community";
  static const String SLIDER_DESC_1 =
      "You can set your schedule watering plant properly and can exchange schedule automatically if come a bad climate";
  static const String SLIDER_DESC_2 =
      "You can scan information of your plant or a pest that harm your plant and get information how to take care that problems.";
  static const String SLIDER_DESC_3 =
      "You can create group or community of your garden or community in your city. And you can also trade, lend, buy, or share any goods with other people";
}

const stateSuccess = Color(0xFF7be495);
const stateWarning = Color(0xFFFFCF5C);
const stateError = Color(0xFFF75010);

const primaryTextColor = Colors.black87;
const primaryColor2 = Color(0xFF899c87);
const primaryColor = Color(0xFF6e7d6d);
const primaryColorDark = Colors.black87;
const defaultPadding = 8.0;

const MaterialColor primaryBlack = MaterialColor(
  _blackPrimaryValue,
  <int, Color>{
    50: Color(0xFF000000),
    100: Color(0xFF000000),
    200: Color(0xFF000000),
    300: Color(0xFF000000),
    400: Color(0xFF000000),
    500: Color(_blackPrimaryValue),
    600: Color(0xFF000000),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
  },
);

const int _blackPrimaryValue = 0xFF000000;
