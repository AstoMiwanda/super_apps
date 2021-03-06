import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationPagePopUp extends StatefulWidget {
  NotificationPagePopUp({Key key}) : super(key: key);

  _NotificationPopUp createState() => new _NotificationPopUp();
}

class _NotificationPopUp extends State<NotificationPagePopUp> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  int countRemainderAbsen = 0;
  int countApprovalCuti = 0;

  @override
  initState() {
    super.initState();
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    // If you have skipped STEP 3 then change app_icon to @mipmap/ic_launcher
    var initializationSettingsAndroid =
    new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Plugin example app'),
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new RaisedButton(
                onPressed: _showNotificationWithSound,
                child: new Text('Show Notification With Sound'),
              ),
              new SizedBox(
                height: 30.0,
              ),
              new RaisedButton(
                onPressed: _showNotificationWithoutSound,
                child: new Text('Show Notification Without Sound'),
              ),
              new SizedBox(
                height: 30.0,
              ),
              new RaisedButton(
                onPressed: _showNotificationWithDefaultSound,
                child: new Text('Show Notification With Default Sound'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future onSelectNotification(String payload) {
    showDialog(
      context: context,
      builder: (_) {
        return new AlertDialog(
          title: Text("PayLoad"),
          content: Text("$payload"),
        );
      },
    );
  }

  // If you have skipped step 4 then Method 1 is not for you

// Method 1
  Future _showNotificationWithSound() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        sound: 'slow_spring_board',
        importance: Importance.Max,
        priority: Priority.High);
    var iOSPlatformChannelSpecifics =
    new IOSNotificationDetails(sound: "slow_spring_board.aiff");
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'New Post',
      'How to Show Notification in Flutter',
      platformChannelSpecifics,
      payload: 'Custom_Sound',
    );
    print("asto azza");
  }
// Method 2
  Future _showNotificationWithDefaultSound() async {
    countRemainderAbsen++;
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    if (countRemainderAbsen <= 1) {
      await flutterLocalNotificationsPlugin.show(
        0,
        'Reamainder Absen',
        'How to Show Notification in Flutter',
        platformChannelSpecifics,
        payload: 'Default_Sound',
      );
    } else {
      await flutterLocalNotificationsPlugin.show(
        0,
        'Reamainder Absen',
        'You have '+countRemainderAbsen.toString()+' remainder absen',
        platformChannelSpecifics,
        payload: 'Default_Sound',
      );
    }
    print("azza");
  }
// Method 3
  Future _showNotificationWithoutSound() async {
    countApprovalCuti++;
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        playSound: false, importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics =
    new IOSNotificationDetails(presentSound: false);
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    if (countApprovalCuti <= 1) {
      await flutterLocalNotificationsPlugin.show(
        1,
        'Aprroval Cuti',
        'How to Show Notification in Flutter',
        platformChannelSpecifics,
        payload: 'Notification Approval',
      );
    } else {
      await flutterLocalNotificationsPlugin.show(
        1,
        'Aprroval Cuti',
        'You have '+countApprovalCuti.toString()+' cuti to approval',
        platformChannelSpecifics,
        payload: 'Notification Approval',
      );
    }
    print("asto");
    print(countApprovalCuti);
  }

}