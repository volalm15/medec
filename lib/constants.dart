import 'dart:ui';

import 'package:flutter/material.dart';

class Constants {
  static const String POPPINS = "Poppins";
  static const String OPEN_SANS = "OpenSans";
  static const String SKIP = "Skip";
  static const String NEXT = "Next";
  static const String SLIDER_HEADING_1 = "Tracking without worry!";
  static const String SLIDER_HEADING_2 = "Get Information About Your Patients!";
  static const String SLIDER_DESC_2 =
      "All in one view! Get your patient data directly in 1 single view";
  static const String SLIDER_DESC_1 =
      "You can save information of your patients and and use it when you need it!";
}

const stateSuccess = Color(0xFF7be495);
const stateWarning = Color(0xFFFFCF5C);
const stateError = Color(0xFFF75010);

const primaryIconColor = Colors.grey;
const primaryTextColor = Colors.black87;
const primaryColor2 = Colors.orange;
const primaryColor = Colors.orangeAccent;
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
