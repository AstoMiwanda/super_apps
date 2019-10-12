import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:super_apps/api/api.dart' as api;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_apps/style/string.dart' as string;
import 'package:super_apps/style/theme.dart' as theme;

double widthDevice;
double heightDevice;
double heightAppBar;
int numNotification;
bool readNotification;

Color bgIcon;
Color bgNotifStatus;
Color bgNotifLine;

String typeNotification;
String iconNotif;
String titleNotif;
String descNotif;
String dateNotif;
String timeNotif;

List<dataNotification> list_notification;

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPage createState() => _NotificationPage();
}

class _NotificationPage extends State<NotificationPage> {
  @override
  void initState() {
    super.initState();
    getDataNotif();
  }

  listNotification({String read, String type, String title, String message}) {
    if (read == '1') {
      bgNotifStatus = Colors.white;
      bgNotifLine = theme.Colors.backgroundNotificationUnread;
    } else {
      bgNotifStatus = theme.Colors.backgroundNotificationUnread;
      bgNotifLine = Colors.white;
    }

    print(read);
    if (type == "remainder") {
      iconNotif = string.text.uri_remainder_notification;
      bgIcon = theme.Colors.backgroundRemainderNotification;
    } else if (type == "approval") {
      iconNotif = string.text.uri_approval_notification;
      bgIcon = theme.Colors.backgroundApprovalNotification;
    } else if (type == "absen") {
      iconNotif = string.text.uri_absen_notification;
      bgIcon = theme.Colors.backgroundAbsenNotification;
    } else {
      iconNotif = '';
      bgIcon = Colors.red;
    }

    if (numNotification == 0) {
      return Container(
        height: heightDevice - (heightAppBar + 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 147.0,
              margin: EdgeInsets.only(bottom: 16.0),
              child: SvgPicture.asset(string.text.uri_empty_notification,
                  placeholderBuilder: (context) => Icon(Icons.error)),
            ),
            Text(
              string.text.lbl_tidak_ada_notification,
              style: TextStyle(color: theme.Colors.colorTextGray_60),
            )
          ],
        ),
      );
    } else {
      return Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16.0),
            color: bgNotifStatus,
            child: Row(
              children: <Widget>[
                Container(
                  width: 60.0,
                  height: 60.0,
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: bgIcon,
                  ),
                  child: SvgPicture.asset(iconNotif,
                      placeholderBuilder: (context) => Icon(Icons.error)),
                ),
                Container(
                  margin: EdgeInsets.only(left: 16.0),
                  width: widthDevice - (108.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 14.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: theme.Colors.colorTextGray,
                              ),
                            ),
                            Text(
                              message,
                              style: TextStyle(
                                  color: theme.Colors.colorTextGray,
                                  fontSize: 12.0,
                                  height: 1.4),
                            )
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            dateNotif + '\n' + timeNotif,
                            style: TextStyle(
                                fontSize: 11.0,
                                color: theme.Colors.colorTextGray_60),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 2.0,
            color: bgNotifLine,
          )
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      backgroundColor: theme.Colors.backgroundHumanCapital,
      title: Text(string.text.page_lihat_kantor,
          style: TextStyle(color: Colors.white)),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context, false),
      ),
    );

    setState(() {
      widthDevice = MediaQuery.of(context).size.width;
      heightDevice = MediaQuery.of(context).size.height;
      heightAppBar = appBar.preferredSize.height;
      dateNotif = "16 September 2019";
      timeNotif = "10.00";
      typeNotification = "approval";
    });

    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: ListView.builder(
            itemCount: list_notification.length == 0 ? 1 : list_notification.length,
            itemBuilder: (context, index) {
              if (list_notification.length == 0) {
                return listNotification();
              } else {
                return listNotification(
                    read: list_notification[index].status_opened,
                    type: typeNotification,
                    title: list_notification[index].title,
                    message: list_notification[index].message);
              }
            }),
      ),
    );
  }

  void getDataNotif () async {
    var nik = "955139";
    final uri = api.Api.notification + "$nik/1";
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    Response response = await get(uri, headers: headers);
    var data = jsonDecode(response.body);
    var data_profile = (data["data"] as List)
        .map((data) => new dataNotification.fromJson(data))
        .toList();
    foreachHasil(data_profile);
  }

  void foreachHasil(List<dataNotification> data_notification) {
    print(data_notification.length);
    setState(() {
      list_notification = data_notification;
    });

    for(int i = 0;i < data_notification.length;i++){
      print(data_notification[i].title);
    }
  }
}

class dataNotification {
  String nik;
  String title;
  String message;
  String date_created;
  String date;
  String time;
  String status_opened;

  dataNotification(
      {this.nik,
        this.title,
        this.message,
        this.date_created,
        this.date,
        this.time,
        this.status_opened});

  factory dataNotification.fromJson(Map<String, dynamic> parsedJson) {
    print(DateTime.parse(parsedJson['date_created'].toString()));
    return dataNotification(
        nik: parsedJson['nik'].toString(),
        title: parsedJson['title'].toString(),
        message: parsedJson['message'].toString(),
        date_created: parsedJson['date_created'].toString(),
        time: parsedJson['date_created'].toString(),
        status_opened: parsedJson['status_opened'].toString()
    );
  }
}