import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_apps/api/api.dart' as api;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_apps/style/string.dart' as string;
import 'package:super_apps/style/theme.dart' as theme;
import 'package:toast/toast.dart';

double widthDevice;
double heightDevice;
double heightAppBar;
BuildContext ctx;

Color bgIcon;
Color bgNotifStatus;
Color bgNotifLine;

String iconNotif;

String nik = '211900';
String message;

List<dataNotification> list_notification;

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPage createState() => _NotificationPage();
}

class _NotificationPage extends State<NotificationPage> {
  @override
  void initState() {
    super.initState();
    getNik();
//    getDataNotif();
  }

  nothingListNotification() {
    return Container(
      height: heightDevice - (heightAppBar + 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 147.0,
            margin: EdgeInsets.only(bottom: 16.0),
            child: SvgPicture.asset(string.Icons.uri_empty_notification,
                placeholderBuilder: (context) => Icon(Icons.error)),
          ),
          Text(
            string.Text.lbl_tidak_ada_notification,
            style: TextStyle(color: theme.Colors.colorTextGray_60),
          )
        ],
      ),
    );
  }

  dataListNotification(
      {String id,
      String title,
      String message,
      String date,
      String time,
      int index}) {
    return GestureDetector(
      onTap: () {
        readDataNotif(id);
        setState(() {
          list_notification[index].status_opened = '1';
        });
      },
      child: Column(
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
                            date + '\n' + time,
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
      ),
    );
  }

  listNotification(
      {String id,
      String title,
      String message,
      String type,
      String date,
      String time,
      String read,
      int index}) {
    if (read == '1') {
      bgNotifStatus = Colors.white;
      bgNotifLine = theme.Colors.backgroundNotificationUnread;
    } else {
      bgNotifStatus = theme.Colors.backgroundNotificationUnread;
      bgNotifLine = Colors.white;
    }

    if (type == "remainder") {
      iconNotif = string.Icons.uri_remainder_notification;
      bgIcon = theme.Colors.backgroundRemainderNotification;
    } else if (type == "approval") {
      iconNotif = string.Icons.uri_approval_notification;
      bgIcon = theme.Colors.backgroundApprovalNotification;
    } else if (type == "absen") {
      iconNotif = string.Icons.uri_absen_notification;
      bgIcon = theme.Colors.backgroundAbsenNotification;
    } else {
      iconNotif = '';
      bgIcon = Colors.red;
    }

    if (list_notification == null) {
      return nothingListNotification();
    } else if (list_notification.length == 0) {
      return nothingListNotification();
    } else {
      return dataListNotification(
          id: id, title: title, message: message, date: date, time: time, index: index);
    }
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;

    AppBar appBar = AppBar(
      backgroundColor: theme.Colors.backgroundHumanCapital,
      title: Text(string.Text.page_notification,
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
    });

    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: ListView.builder(
            itemCount: list_notification == null
                ? 1
                : list_notification.length == 0 ? 1 : list_notification.length,
            itemBuilder: (context, index) {
              if (list_notification == null) {
                return listNotification();
              } else if (list_notification.length == 0) {
                return listNotification();
              } else {
                return listNotification(
                    id: list_notification[index].id,
                    title: list_notification[index].title,
                    message: list_notification[index].message,
                    type: list_notification[index].type,
                    date: list_notification[index].date,
                    time: list_notification[index].time,
                    read: list_notification[index].status_opened,
                    index: index);
              }
            }),
      ),
    );
  }

  getNik() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nik = (prefs.getString('username') ?? '');
      getDataNotif();
    });
  }

  void getDataNotif() async {    
    final uri = api.Api.notification + "$nik/1";
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    try {
      Response response = await get(uri, headers: headers);
      var data = jsonDecode(response.body);
      var data_profile = (data["data"] as List)
          .map((data) => new dataNotification.fromJson(data))
          .toList();
      foreachHasil(data_profile);  

    } catch (e) {
      message = string.Message.msg_server_err;
      Toast.show(message, ctx,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

    }
    
  }

  void readDataNotif(id) async {
    final uri = api.Api.read_notification;
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    final encoding = Encoding.getByName('utf-8');
    try {
      Response response = await post(
        uri,
        headers: headers,
        body: "id=" + id,
        encoding: encoding,
      );
      var data = jsonDecode(response.body);
      var data_notif = data["data"];
      print(data_notif);

    } catch (e) {
      message = string.Message.msg_server_err;
      Toast.show(message, ctx,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

    }
    
  }

  void foreachHasil(List<dataNotification> data_notification) {
    setState(() {
      list_notification = data_notification;
    });
  }
}

class dataNotification {
  String id;
  String nik;
  String title;
  String message;
  String type;
  String date;
  String time;
  String status_opened;

  dataNotification(
      {this.id,
      this.nik,
      this.title,
      this.message,
      this.type,
      this.date,
      this.time,
      this.status_opened});

  factory dataNotification.fromJson(Map<String, dynamic> parsedJson) {
    return dataNotification(
        id: parsedJson['no'].toString(),
        nik: parsedJson['nik'].toString(),
        title: parsedJson['title'].toString(),
        message: parsedJson['message'].toString(),
        type: parsedJson['type'].toString(),
        date: parsedJson['date'].toString(),
        time: parsedJson['time'].toString(),
        status_opened: parsedJson['status_opened'].toString());
  }
}
