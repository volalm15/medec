import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:medec/constants.dart';
import 'package:medec/pages/dashboard/components/add_patient.dart';
import 'package:medec/pages/dashboard/dashboard.dart';
import 'package:medec/size_config.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _page = 0;
  var _pageOption = [
    Dashboard(),
  ];
  var _pageController = PageController(initialPage: 0);

  FlutterLocalNotificationsPlugin _notificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();

    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var ios = IOSInitializationSettings();
    var initSettings = InitializationSettings(android: android, iOS: ios);
    _notificationsPlugin.initialize(initSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) {
    debugPrint("payload : $payload");
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        title: new Text('Notification'),
        content: new Text('$payload'),
      ),
    );
  }

  showNotification() async {
    var android = new AndroidNotificationDetails(
        'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
        priority: Priority.high, importance: Importance.max);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: iOS);
    await _notificationsPlugin.show(
        0, 'New Video is out', 'Flutter Local Notification', platform,
        payload: 'Nitish Kumar Singh is part time Youtuber');
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddPatient()),
            );
          }),
      extendBody: false,
      body: PageView(
        children: _pageOption,
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            showNotification();
            _page = index;
          });
        },
      ),
    );
  }
}
