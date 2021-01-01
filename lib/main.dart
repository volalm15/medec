import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:medec/login/login.dart';
import 'package:medec/onboarding/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';
import 'home/home.dart';

Future<void> main() async {
  try {
    bool _firstUse = true;
    initializeDateFormatting('de_DE', null);
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('first_use')) {
      _firstUse = prefs.getBool('first_use');
    } else {
      prefs.setBool('first_use', true);
    }
    runApp(MyApp(_firstUse));
  } catch (e) {
    print(e);
  }
}

class MyApp extends StatelessWidget {
  final bool _firstUse;
  MyApp(this._firstUse);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Medec',
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
          primaryColor: primaryColor,
          errorColor: stateError,
          primarySwatch: primaryColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: _firstUse
            ? Onboarding()
            : StreamBuilder<User>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.active:
                      {
                        User user = snapshot.data;
                        if (user == null) {
                          return Login();
                        }
                        return Home();
                      }

                    default:
                      return Text('Error: ${snapshot.error}');
                  }
                },
              ));
  }
}
